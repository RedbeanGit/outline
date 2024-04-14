{{/*
Get google secret name
*/}}
{{- define "outline.google.secretName" -}}
  {{- if .Values.auth.google.existingSecret -}}
    {{- printf "%s" (tpl .Values.auth.google.existingSecret $) -}}
  {{- else -}}
    {{- printf "%s-google" (include "outline.fullname" $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created
*/}}
{{- define "outline.google.createSecret" -}}
  {{- if not .Values.auth.google.existingSecret -}}
    {{- true -}}
  {{- end -}}
{{- end -}}