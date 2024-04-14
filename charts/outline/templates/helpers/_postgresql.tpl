{{/*
Return the postgresql username
*/}}
{{- define "outline.postgresql.username" -}}
  {{- if .Values.postgresql.auth.username -}}
    {{- .Values.postgresql.auth.username -}}
  {{- else -}}
    postgres
  {{- end -}}
{{- end -}}

{{/*
Return the postgresql password. Can lookup in an existing secret or generate a new one.
*/}}
{{- define "outline.postgresql.password" -}}
  {{- if .Values.postgresql.auth.existingSecret -}}
    {{- $secret := (lookup "v1" "Secret" .Release.Namespace .Values.postgresql.auth.existingSecret) -}}
    {{- $secretKey := .Values.postgresql.auth.secretKeys.adminPasswordKey .Values.postgresql.auth.secretKeys.userPasswordKey (eq (include "outline.postgresql.username" $) "postgres") -}}
    {{- if $secretKey -}}
      {{- index $secret.data $secretKey -}}
    {{- else -}}
      {{- fail "postgresql.auth.secretKeys.userPasswordKey is not set" -}}
    {{- end -}}
  {{- else if .Values.postgresql.auth.password -}}
    {{- .Values.postgresql.auth.password | b64enc -}}
  {{- else -}}
    {{- fail "postgresql.auth.existingSecret or postgresql.auth.password should be set" -}}
  {{- end -}}
{{- end -}}

{{/*
Return postgresql fullname
*/}}
{{- define "outline.postgresql.fullname" -}}
  {{- if .Values.postgresql.fullnameOverride -}}
    {{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- $name := default "postgresql" .Values.nameOverride -}}
    {{- if contains $name .Release.Name -}}
      {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Return the postgresql host
*/}}
{{- define "outline.postgresql.host" -}}
  {{- if (eq .Values.postgresql.architecture "replication") -}}
    {{- if .Values.databaseHost -}}
      {{- .Values.databaseHost -}}
    {{- else if .Values.postgresql.primary.name -}}
      {{- printf "%s-%s.%s.svc.cluster.local" (include "outline.postgresql.fullname" $) .Values.postgresql.primary.name .Release.Namespace -}}
    {{- else -}}
      {{- printf "%s-primary.%s.svc.cluster.local" (include "outline.postgresql.fullname" $) .Release.Namespace -}}
    {{- end -}}
  {{- else if .Values.databaseHost -}}
    {{- .Values.databaseHost -}}
  {{- else -}}
    {{- printf "%s.%s.svc.cluster.local" (include "outline.postgresql.fullname" $) .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Return the postgresql url
*/}}
{{- define "outline.databaseUrl" -}}
  {{- printf "postgresql://%s:%s@%s:%s/%s" (include "outline.postgresql.username" $) (include "outline.postgresql.password" $ | b64dec) (include "outline.postgresql.host" $) (toString .Values.databasePort) .Values.postgresql.auth.database -}}
{{- end -}}

{{/*
Return postgresql url secret name
*/}}
{{- define "outline.databaseUrlSecretName" -}}
  {{- printf "%s-%s" (include "outline.fullname" .) "database-url" -}}
{{- end -}}
