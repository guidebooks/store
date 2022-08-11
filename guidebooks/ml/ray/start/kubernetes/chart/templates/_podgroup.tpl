{{- define "podgroup" -}}
apiVersion: scheduling.sigs.k8s.io/v1alpha1
kind: PodGroup
metadata:
  name: {{ include "ray.podgroup" . }}
  namespace: {{ .Values.clusterNamespace }}
spec:
  minMember: {{ add .Values.podTypes.rayWorkerType.maxWorkers 1 }} # workers + 1 for head pod
  scheduleTimeoutSeconds: 10
{{end}}
