{{- define "worker-deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "ray.workers" . }}
  namespace: {{ .Values.clusterNamespace }}
spec:
  replicas: {{ .Values.podTypes.rayWorkerType.maxWorkers | default 1 }}
  selector:
    matchLabels:
      component: ray-worker
      type: ray
  template:
    metadata:
      labels:
        component: ray-worker
        type: ray
        appwrapper.mcad.ibm.com: {{ .Values.clusterName }}
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
      {{ end }}

      restartPolicy: Always
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
          - {{ print "ray start --num-cpus=" .Values.podTypes.rayWorkerType.CPUInteger " --num-gpus=" .Values.podTypes.rayWorkerType.GPU " --address=" (include "ray.headService" .) ":6379 --object-manager-port=22345 --node-manager-port=22346 --block" }}

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
        {{- if .Values.pvcs }}
        {{- if .Values.pvcs.claims }}
        {{- range $key, $val := .Values.pvcs.claims }}
          - name: {{ regexReplaceAll "\\." $val.name "-" }}
            mountPath: {{ $val.mountPath }}
        {{- end }}
        {{- end }}
        {{- end }}
        env:
        resources:
          requests:
            cpu: {{ .Values.podTypes.rayWorkerType.CPU }}
            memory: {{ .Values.podTypes.rayWorkerType.memory }}
            ephemeral-storage: {{ .Values.podTypes.rayWorkerType.storage }}
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
