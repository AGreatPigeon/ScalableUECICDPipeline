{{- define "scalable-ue5-pipeline.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "scalable-ue5-pipeline.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
