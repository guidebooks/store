{{- define "head-service" -}}
# Ray head node service, allowing worker pods to discover the head node.
apiVersion: v1
kind: Service
metadata:
  name: {{ include "ray.headService" . }}
  namespace: {{ .Values.clusterNamespace }}
spec:
  ports:
  - name: client
    protocol: TCP
    port: 10001
    targetPort: 10001
  - name: dashboard
    protocol: TCP
    port: 8265
    targetPort: 8265
  - name: redis
    protocol: TCP
    port: 6379
    targetPort: 6379
  selector:
    component: ray-head
{{end}}