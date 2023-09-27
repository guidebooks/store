{{- define "worker-deployment" -}}
{{ if gt .Values.podTypes.rayWorkerType.maxWorkers 0 }}
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "ray.workers" . }}
  namespace: {{ .Values.clusterNamespace }}
spec:
  ttlSecondsAfterFinished: 100
  parallelism: {{ .Values.podTypes.rayWorkerType.maxWorkers | default 1 }}
  completions: {{ .Values.podTypes.rayWorkerType.maxWorkers | default 1 }}
  template:
    metadata:
      annotations:
        {{- if .Values.multinic }}
        k8s.v1.cni.cncf.io/networks: {{ .Values.multinic }}
        {{- end }}
      labels:
        component: ray-worker
        type: ray
        appwrapper.workload.codeflare.dev: {{ .Values.clusterName }}
        app.kubernetes.io/name: {{ .Values.clusterName }}
        app.kubernetes.io/instance: {{ .Values.clusterName }}
        app.kubernetes.io/owner: {{ .Values.userName | default "unknown" }}
        ray-node-type: worker
        ray-cluster-name: {{ .Values.clusterName }}
        ray-user-node-type: rayWorkerType
        ray-node-name: {{ include "ray.workers" . }}

        {{ if eq .Values.mcad.scheduler "coscheduler" }}
        pod-group.scheduling.sigs.k8s.io: {{ include "ray.podgroup" . }}
        {{ end }}
    spec:
      {{ if eq .Values.mcad.scheduler "coscheduler" }}
      schedulerName: scheduler-plugins-scheduler
      {{- if .Values.priority }}
      {{ include "priority.className" . }}
      {{ end }}
      {{ end }}

      restartPolicy: OnFailure
      volumes:
      - name: dshm
        emptyDir:
          medium: Memory
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
      - name: ray-worker
        image: {{ .Values.image }}
        imagePullPolicy: {{ .Values.imagePullPolicy }}
        command: ["/bin/bash", "-c", "--"]
        args:
          - {{ print "function start() { sleep $1 ; ray start --num-cpus=" .Values.podTypes.rayWorkerType.CPUInteger " --num-gpus=" .Values.podTypes.rayWorkerType.GPU " --address=" (include "ray.headService" .) ":6379 --object-manager-port=22345 --node-manager-port=22346 --block; } ; start 0 || start 5 || start 10 ; echo \"Ray worker exited with $?\"; exit 0" }}

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
        {{- if .Values.pvcs }}
        {{- if .Values.pvcs.claims }}
        {{- range $key, $val := .Values.pvcs.claims }}
          - name: {{ regexReplaceAll "\\." $val.name "-" }}
            mountPath: {{ $val.mountPath }}
        {{- end }}
        {{- end }}
        {{- end }}

        {{ if .Values.jobEnv }}
        env:
          {{ .Values.jobEnv | b64dec | indent 10 }}
        {{- end }}

        resources:
          requests:
            cpu: {{ .Values.podTypes.rayWorkerType.CPU }}
            memory: {{ .Values.podTypes.rayWorkerType.memory }}
            ephemeral-storage: {{ .Values.podTypes.rayWorkerType.storage }}
            {{- if .Values.podTypes.rayWorkerType.GPU }}
            nvidia.com/gpu: {{ .Values.podTypes.rayWorkerType.GPU }}
            {{- end }}
          limits:
            cpu: {{ .Values.podTypes.rayWorkerType.CPU }}
            # The maximum memory that this pod is allowed to use. The
            # limit will be detected by ray and split to use 10% for
            # redis, 30% for the shared memory object store, and the
            # rest for application memory. If this limit is not set and
            # the object store size is not set manually, ray will
            # allocate a very large object store in each pod that may
            # cause problems for other pods.
            memory: {{ .Values.podTypes.rayWorkerType.memory }}
            ephemeral-storage: {{ .Values.podTypes.rayWorkerType.storage }}
            {{- if .Values.podTypes.rayWorkerType.GPU }}
            nvidia.com/gpu: {{ .Values.podTypes.rayWorkerType.GPU }}
            {{- end }}
{{end}}
{{end}}
