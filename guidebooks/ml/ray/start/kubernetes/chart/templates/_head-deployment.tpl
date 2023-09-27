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
    appwrapper.workload.codeflare.dev: {{ .Values.clusterName }}
    app.kubernetes.io/name: {{ .Values.clusterName }}
    app.kubernetes.io/instance: {{ .Values.clusterName }}
    app.kubernetes.io/owner: {{ .Values.userName | default "unknown" }}
spec:
  ttlSecondsAfterFinished: 100
  # Do not change this - Ray currently only supports one head node per cluster.
  completions: 1
  template:
    metadata:
      name: {{ include "ray.head" . }}
      namespace: {{ .Values.clusterNamespace }}
      annotations:
        {{- if .Values.multinic }}
        k8s.v1.cni.cncf.io/networks: {{ .Values.multinic }}
        {{- end }}
      labels:
        component: ray-head
        type: ray
        appwrapper.workload.codeflare.dev: {{ .Values.clusterName }}
        app.kubernetes.io/name: {{ .Values.clusterName }}
        app.kubernetes.io/instance: {{ .Values.clusterName }}
        app.kubernetes.io/owner: {{ .Values.userName | default "unknown" }}
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

      {{ if gt .Values.podTypes.rayWorkerType.maxWorkers 0 }}
      initContainers:
        - name: wait-for-workers
          image: bitnami/kubectl
          command: ["/bin/sh", "-c", "--"]
          args:
            - {{ print "echo 'Waiting for workers'; while true; do kubectl wait pod -l " (.Values.podTypes.rayWorkerType.selector) " --for=condition=Ready --timeout=-1s && break; sleep 1; done; echo 'Workers are ready'" }}
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
            - {{ print "set -e; set -o pipefail; export TERM=xterm-256color; " (include "ray.head.args" .) "; mkdir /tmp/workdir; tar -C /tmp/workdir -zxf /tmp/configmap/workdir/workdir.tar.gz; if [ ! -f /tmp/workdir/runtime-env.yaml ]; then touch /tmp/workdir/runtime-env.yaml; if [ -f /tmp/workdir/requirements.txt ]; then echo 'Splicing in requirements.txt'; awk 'BEGIN { print \"pip:\" } NF > 0 { print \"  - \" $0 }' /tmp/workdir/requirements.txt >> /tmp/workdir/runtime-env.yaml; fi; fi ; if [ -s /tmp/workdir/runtime-env.yaml ]; then echo 'Using runtime-env.yaml'; RUNTIME_ENV=\"--runtime-env=/tmp/workdir/runtime-env.yaml\"; fi; ls -l /tmp/workdir ; set +e; echo -e \"$(tput bold)$(tput dim)$(tput setaf 2)[Job $(tput sgr0)$(tput setaf 2)Submitted$(tput bold)$(tput dim)$(tput setaf 2)] $(tput sgr0)$(tput dim)$(tput setaf 2)Submitting job to ray$(tput sgr0)\"; ray job submit --job-id " (.Values.jobId) " --address http://localhost:8265 --working-dir=/tmp/workdir $RUNTIME_ENV -- " (.Values.commandLinePrefix | default "python3 main.py") " " (.Values.dashdash | default "" | b64dec) " > /tmp/jobout.txt ; if [[ $? = 0 ]]; then jobstatus=Success; else jobstatus=Failed; fi; echo \"$(tput bold)$(tput dim)$(tput setaf 2)[Job $(tput sgr0)$(tput setaf 2)${jobstatus-Unknown}$(tput bold)$(tput dim)$(tput setaf 2)] $(tput sgr0)$(tput dim)$(tput setaf 2)Job has completed$(tput sgr0)\"; tail /tmp/jobout.txt | grep -E 'Job|---' 2> /dev/null; echo \"Shutting down Ray\"; ray stop > /tmp/stop.out 2> /tmp/stop.err" }}
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
            failureThreshold: {{ .Values.startupProbe.failureThreshold | default 100 }}
            initialDelaySeconds: {{ .Values.startupProbe.initialDelaySeconds | default 4 }}
            httpGet:
              path: /
              port: 8265

          # make openshift local happy
          # securityContext:
          #   runAsNonRoot: true
          #   allowPrivilegeEscalation: false

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
              {{- if .Values.podTypes.rayWorkerType.GPU }}
              nvidia.com/gpu: {{ .Values.podTypes.rayWorkerType.GPU }}
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
              {{- if .Values.podTypes.rayWorkerType.GPU }}
              nvidia.com/gpu: {{ .Values.podTypes.rayWorkerType.GPU }}
              {{- end }}

        - name: logs
          image: ghcr.io/project-codeflare/custodian:0.0.2
          resources:
           limits:
             cpu: 50m
             memory: 128Mi

          command: [ "/bin/bash", "-c", "--" ]
          args:
            - |
              {{ print "while true; do websocat --text --no-line ws://" (include "ray.headService" .) ":8265/api/jobs/" (.Values.jobId) "/logs/tail 2> /dev/null && break ; sleep 1; done" }}
{{- end }}
