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

{{- define "ray.workdir" -}}
{{- trunc 63 (print "ray-workdir-" .Values.clusterName) -}}
{{- end }}

{{- define "ray.head.args" -}}
{{ print "ray start --head --port=6379 --redis-shard-ports=6380,6381 --num-cpus=" .Values.podTypes.rayHeadType.CPUInteger " --num-gpus=" .Values.podTypes.rayHeadType.GPU " --object-manager-port=22345 --node-manager-port=22346 --dashboard-host=0.0.0.0 --storage=" .Values.storage.path }}
{{- end }}