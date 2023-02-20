{{- define "ray.podgroup" -}}
{{- trunc 63 (print "ray-pg-" .Values.clusterName) }}
{{- end }}

{{- define "ray.head" -}}
{{- trunc 63 (print "ray-head-" .Values.clusterName) -}}
{{- end }}

{{- define "ray.workers" -}}
{{- trunc 63 (print "ray-worker-" .Values.clusterName) -}}
{{- end }}

{{- define "ray.headService" -}}
{{- trunc 63 (print "ray-head-" .Values.clusterName) -}}
{{- end }}

{{- define "ray.serviceaccount" -}}
{{- trunc 63 (print "ray-sa-" .Values.clusterName) -}}
{{- end }}

{{- define "ray.role" -}}
{{- trunc 63 (print "ray-role-" .Values.clusterName) -}}
{{- end }}

{{- define "ray.rolebinding" -}}
{{- trunc 63 (print "ray-rb-" .Values.clusterName) -}}
{{- end }}
