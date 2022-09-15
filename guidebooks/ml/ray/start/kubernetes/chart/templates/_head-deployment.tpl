{{- define "head-deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "ray.head" . }}
  namespace: {{ .Values.clusterNamespace }}
  labels:
    component: ray-head
    type: ray
    appwrapper.mcad.ibm.com: {{ .Values.clusterName }}
spec:
  # Do not change this - Ray currently only supports one head node per cluster.
  replicas: 1
  selector:
    matchLabels:
      component: ray-head
      type: ray
  template:
    metadata:
      name: {{ include "ray.head" . }}
      namespace: {{ .Values.clusterNamespace }}
      labels:
        component: ray-head
        type: ray
        appwrapper.mcad.ibm.com: {{ .Values.clusterName }}
        ray-node-type: head
        ray-cluster-name: {{ .Values.clusterName }}
        ray-user-node-type: rayHeadType
        ray-node-name: {{ include "ray.head" . }}

        {{ if eq .Values.mcad.scheduler "coscheduler" }}
        pod-group.scheduling.sigs.k8s.io: {{ include "ray.podgroup" . }}
        {{ end }}
    spec:
      serviceAccountName: ray-head-serviceaccount

      {{ if eq .Values.mcad.scheduler "coscheduler" }}
      schedulerName: scheduler-plugins-scheduler
      {{ end }}

      # If the head node goes down, the entire cluster (including all worker
      # nodes) will go down as well. If you want Kubernetes to bring up a new
      # head node in this case, set this to "Always," else set it to "Never."
      restartPolicy: Always

      # This volume allocates shared memory for Ray to use for its plasma
      # object store. If you do not provide this, Ray will fall back to
      # /tmp which cause slowdowns if is not a shared memory volume.
      volumes:
      - name: dshm
        emptyDir:
          medium: Memory
      containers:
        - name: ray-head
          image: {{ .Values.image }}
          imagePullPolicy: IfNotPresent
          command: [ "/bin/bash", "-c", "--" ]
          args:
            - {{ print "ray start --head --port=6379 --redis-shard-ports=6380,6381 --num-cpus=" .Values.podTypes.rayHeadType.CPUInteger " --num-gpus=" .Values.podTypes.rayHeadType.GPU " --object-manager-port=22345 --node-manager-port=22346 --dashboard-host=0.0.0.0 --block" }}
          ports:
            - containerPort: 6379 # Redis port
            - containerPort: 10001 # Used by Ray Client
            - containerPort: 8265 # Used by Ray Dashboard
            - containerPort: 8000 # Used by Ray Serve

          startupProbe:
            periodSeconds: {{ .Values.startupProbe.periodSeconds | default 10 }}
            failureThreshold: {{ .Values.startupProbe.failureThreshold | default 10 }}
            initialDelaySeconds: {{ .Values.startupProbe.initialDelaySeconds | default 5 }}
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
          env:
          resources:
            requests:
              cpu: {{ .Values.podTypes.rayHeadType.CPU }}
              memory: {{ .Values.podTypes.rayHeadType.memory }}
            limits:
              cpu: {{ ceil (mul .Values.podTypes.rayHeadType.CPUInteger 2) }}
              # The maximum memory that this pod is allowed to use. The
              # limit will be detected by ray and split to use 10% for
              # redis, 30% for the shared memory object store, and the
              # rest for application memory. If this limit is not set and
              # the object store size is not set manually, ray will
              # allocate a very large object store in each pod that may
              # cause problems for other pods.
              memory: {{ .Values.podTypes.rayHeadType.memory }}
              {{- if .Values.podTypes.rayHeadType.GPU }}
              nvidia.com/gpu: {{ .Values.podTypes.rayHeadType.GPU }}
              {{- end }}
{{- end }}
