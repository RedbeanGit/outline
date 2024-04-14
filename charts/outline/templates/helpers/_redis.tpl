{{/*
Return redis fullname
*/}}
{{- define "outline.redis.fullname" -}}
  {{- if .Values.redis.fullnameOverride -}}
    {{- .Values.redis.fullnameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- $name := default "redis" .Values.nameOverride -}}
    {{- if contains $name .Release.Name -}}
      {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Return the redis host
*/}}
{{- define "outline.redisHost" -}}
  {{- if .Values.redisHost -}}
    {{- .Values.redisHost | quote -}}
  {{- else -}}
    {{- printf "%s-master.%s.svc.cluster.local" (include "outline.redis.fullname" $) .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Return Redis url
*/}}
{{- define "outline.redisUrl" -}}
  {{- printf "redis://%s:%s" (include "outline.redisHost" $) (toString .Values.redisPort) | quote -}}
{{- end -}}
