{{- define "unreal-app.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "unreal-app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}