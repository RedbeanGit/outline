{{/*
Return MinIO fullname
*/}}
{{- define "outline.minio.fullname" -}}
  {{- if .Values.minio.fullnameOverride -}}
    {{- .Values.minio.fullnameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- $name := default "minio" .Values.nameOverride -}}
    {{- if contains $name .Release.Name -}}
      {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Get MinIO secret name
*/}}
{{- define "outline.minio.secretName" -}}
  {{- if .Values.minio.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
  {{- else -}}
    {{- printf "%s" (include "outline.minio.fullname" $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the MinIO url
*/}}
{{- define "outline.minioUrl" -}}
  {{- printf "http://%s:%s" (include "outline.minio.fullname" $) (toString .Values.minio.service.port.api) | quote -}}
{{- end -}}