{{- define "head-deployment" -}}
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "ray.head" . }}
  namespace: {{ .Values.clusterNamespace }}
  labels:
    component: ray-head
    type: ray
    ray-cluster-name: {{ .Values.clusterName }}
    appwrapper.mcad.ibm.com: {{ .Values.clusterName }}
spec:
  ttlSecondsAfterFinished: 100
  # Do not change this - Ray currently only supports one head node per cluster.
  completions: 1
  template:
    metadata:
      name: {{ include "ray.head" . }}
      namespace: {{ .Values.clusterNamespace }}
      labels:
        component: ray-head
        type: ray
        appwrapper.mcad.ibm.com: {{ .Values.clusterName }}
        app.kubernetes.io/name: {{ .Values.clusterName }}
        ray-node-type: head
        ray-cluster-name: {{ .Values.clusterName }}
        ray-user-node-type: rayHeadType
        ray-node-name: {{ include "ray.head" . }}

        {{ if eq .Values.mcad.scheduler "coscheduler" }}
        pod-group.scheduling.sigs.k8s.io: {{ include "ray.podgroup" . }}
        {{ end }}
    spec:
      {{- if .Values.rbac.enabled }}
      serviceAccountName: {{ include "ray.serviceaccount" . }}
      {{- end }}

      {{ if eq .Values.mcad.scheduler "coscheduler" }}
      schedulerName: scheduler-plugins-scheduler
      {{- if .Values.priority }}
      {{ include "priority.className" . }}
      {{ end }}
      {{ end }}

      # If the head node goes down, the entire cluster (including all worker
      # nodes) will go down as well.
      restartPolicy: OnFailure

      # This volume allocates shared memory for Ray to use for its plasma
      # object store. If you do not provide this, Ray will fall back to
      # /tmp which cause slowdowns if is not a shared memory volume.
      volumes:
      - name: dshm
        emptyDir:
          medium: Memory

      # `volumes` entry for workdir
      {{ if .Values.workdir }}
      - name: workdir-volume
        configMap:
          name: {{ include "ray.workdir" . }}
      {{- end }}

      # `volumes` entries for Persistent Volume Claims
      {{- if .Values.pvcs }}
      {{- if .Values.pvcs.claims }}
      {{- range $key, $val := .Values.pvcs.claims }}
      - name: {{ regexReplaceAll "\\." $val.name "-" }}
        persistentVolumeClaim:
          claimName: {{ regexReplaceAll "\\." $val.name "-" }}
      {{- end }}
      {{- end }}
      {{- end }}
      {{- if .Values.imagePullSecret }}
      imagePullSecrets:
        - name: {{ .Values.imagePullSecret }}
      {{- end }}

      containers:
        - name: ray-head
          image: {{ .Values.image }}
          imagePullPolicy: {{ .Values.imagePullPolicy }}
          command: [ "/bin/bash", "-c", "--" ]

          {{ if .Values.jobEnv }}
          env:
            {{ .Values.jobEnv | b64dec | indent 12 }}
          {{- end }}

          {{ if or .Values.storage.secret .Values.workdir }}
          envFrom:
          {{ if .Values.storage.secret }}
            - secretRef:
                name: {{ .Values.storage.secret }}
          {{- end }}
          {{- end }}

          args:
          {{ if .Values.workdir }}
            - {{ print "set -e; set -o pipefail; " (include "ray.head.args" .) "; mkdir /tmp/workdir; tar -C /tmp/workdir -zxf /tmp/configmap/workdir/workdir.tar.bz2; if [ ! -f /tmp/workdir/runtime-env.yaml ]; then touch /tmp/workdir/runtime-env.yaml; if [ -f /tmp/workdir/requirements.txt ]; then echo 'Splicing in requirements.txt'; awk 'BEGIN { print \"pip:\" } NF > 0 { print \"  - \" $0 }' /tmp/workdir/requirements.txt >> /tmp/workdir/runtime-env.yaml; fi; fi ; if [ -s /tmp/workdir/runtime-env.yaml ]; then echo 'Using runtime-env.yaml'; RUNTIME_ENV=\"--runtime-env=/tmp/workdir/runtime-env.yaml\"; fi; ls -l /tmp/workdir ; set +e; ray job submit --job-id " (.Values.jobId) " --address http://localhost:8265 --working-dir=/tmp/workdir $RUNTIME_ENV -- " (.Values.commandLinePrefix | default "python3 main.py") " " (.Values.dashdash | default "" | b64dec) "; echo \"Job complete, shutting down ray in 30 seconds...\"; sleep 30; ray stop" }}
          {{ else }}
            - {{ print (include "ray.head.args" .) " --block" }}
          {{ end }}

          ports:
            - containerPort: 6379 # Redis port
            - containerPort: 10001 # Used by Ray Client
            - containerPort: 8265 # Used by Ray Dashboard
            - containerPort: 8000 # Used by Ray Serve

          startupProbe:
            periodSeconds: {{ .Values.startupProbe.periodSeconds | default 2 }}
            failureThreshold: {{ .Values.startupProbe.failureThreshold | default 50 }}
            initialDelaySeconds: {{ .Values.startupProbe.initialDelaySeconds | default 2 }}
            httpGet:
              path: /
              port: 8265

          # make openshift local happy
          securityContext:
            runAsNonRoot: true
            allowPrivilegeEscalation: false

          # This volume allocates shared memory for Ray to use for its plasma
          # object store. If you do not provide this, Ray will fall back to
          # /tmp which cause slowdowns if is not a shared memory volume.
          volumeMounts:
            - mountPath: /dev/shm
              name: dshm

          # `volumeMounts` entries for workdir
          {{ if .Values.workdir }}
            - name: workdir-volume
              mountPath: /tmp/configmap/workdir
              readOnly: true
          {{- end }}
              
          # `volumeMounts` entries for PersistentVolumeClaims
          {{- if .Values.pvcs }}
          {{- if .Values.pvcs.claims }}
          {{- range $key, $val := .Values.pvcs.claims }}
            - name: {{ regexReplaceAll "\\." $val.name "-" }}
              mountPath: {{ $val.mountPath }}
          {{- end }}
          {{- end }}
          {{- end }}
          resources:
            requests:
              cpu: {{ .Values.podTypes.rayHeadType.CPU }}
              memory: {{ .Values.podTypes.rayHeadType.memory }}
              ephemeral-storage: {{ .Values.podTypes.rayHeadType.storage }}
              {{- if .Values.podTypes.rayHeadType.GPU }}
              nvidia.com/gpu: {{ .Values.podTypes.rayHeadType.GPU }}
              {{- end }}
            limits:
              cpu: {{ .Values.podTypes.rayHeadType.CPU }}
              # The maximum memory that this pod is allowed to use. The
              # limit will be detected by ray and split to use 10% for
              # redis, 30% for the shared memory object store, and the
              # rest for application memory. If this limit is not set and
              # the object store size is not set manually, ray will
              # allocate a very large object store in each pod that may
              # cause problems for other pods.
              memory: {{ .Values.podTypes.rayHeadType.memory }}
              ephemeral-storage: {{ .Values.podTypes.rayHeadType.storage }}
              {{- if .Values.podTypes.rayHeadType.GPU }}
              nvidia.com/gpu: {{ .Values.podTypes.rayHeadType.GPU }}
              {{- end }}
{{- end }}
