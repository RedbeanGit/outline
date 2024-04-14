{{/*
Get Outline secret name
*/}}
{{- define "outline.secretName" -}}
  {{- if .Values.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
  {{- else -}}
    {{- printf "%s" (include "outline.fullname" $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created
*/}}
{{- define "outline.createSecret" -}}
  {{- if not .Values.existingSecret -}}
    {{- true -}}
  {{- end -}}
{{- end -}}

{{/*
Return a hex-encoded 32-byte random key for secret
*/}}
{{- define "outline.secretKey" -}}
  {{- if .Values.secretKey -}}
    {{- .Values.secretKey | quote -}}
  {{- else -}}
    {{- randAlphaNum 32 | b64enc | quote }}
  {{- end -}}
{{- end -}}

{{/*
Return a hex-encoded 32-byte random key for utils secret
*/}}
{{- define "outline.utilsSecretKey" -}}
  {{- if .Values.utilsSecretKey -}}
    {{- .Values.utilsSecretKey | quote -}}
  {{- else -}}
    {{- randAlphaNum 32 | b64enc | quote }}
  {{- end -}}
{{- end -}}
