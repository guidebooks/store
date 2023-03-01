{{- if .Values.priority -}}
{{- $priorities := list "default-priority" "low-priority" "high-priority" -}}
{{- if eq ( has .Values.priority $priorities ) false -}}
{{- fail ( printf "Field 'priority: \"%s\"' in user file is not correctly set (values possible: 'default-priority', 'low-priority', 'high-priority')" .Values.priority ) -}}
{{- end -}}
{{- end -}}

{{- define "priority.className" -}}
{{- if eq .Values.priority "high-priority" -}}
priorityClassName: "high-priority"
{{- else if eq .Values.priority "low-priority" -}}
priorityClassName: "low-priority"
{{- else -}}
priorityClassName: "default-priority"
{{- end -}}
{{- end -}}

{{- define "priority.value" -}}
{{- if eq .Values.priority "high-priority" -}}
priority: 10
{{- else if eq .Values.priority "low-priority" -}}
priority: 1
{{- else -}}
priority: 5
{{- end -}}
{{- end -}}

{{- define "priority.slope" -}}
priorityslope: 0.0
{{- end -}}
