{{- define "todo-app.name" -}}
todo-app
{{- end }}

{{ define "todo-app.labels" -}}
app.kubernetes.io/name: {{ include "todo-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}