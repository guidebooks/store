{{- define "ray.podgroup" -}}
{{- print .Values.clusterName "-ray-pod-group" }}
{{- end }}

{{- define "ray.head" -}}
{{- print .Values.clusterName "-ray-head" -}}
{{- end }}

{{- define "ray.workers" -}}
{{- print .Values.clusterName "-ray-worker" -}}
{{- end }}

{{- define "ray.headService" -}}
{{- print .Values.clusterName "-ray-head" -}}
{{- end }}

{{- define "ray.serviceaccount" -}}
{{- print .Values.clusterName "-serviceaccount" -}}
{{- end }}

{{- define "ray.role" -}}
{{- print .Values.clusterName "-role" -}}
{{- end }}

{{- define "ray.rolebinding" -}}
{{- print .Values.clusterName "-role" -}}
{{- end }}
