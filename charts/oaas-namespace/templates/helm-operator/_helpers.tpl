
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oaas-namespace.helmop.fullname" -}}
{{- if index .Values "helm-operator" "fullnameOverride" }}
{{- index .Values "helm-operator" "fullnameOverride" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- $helmopName := default "helmop" .Values.name }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name $helmopName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name $helmopName | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
helm operator common labels
*/}}
{{- define "oaas-namespace.helmop.labels" -}}
{{ include "oaas-namespace.helmop.matchLabels" . }}
{{ include "oaas-namespace.metaLabels" . }}
{{- end -}}

{{/*
helm operator selector labels
*/}}
{{- define "oaas-namespace.helmop.matchLabels" -}}
app.kubernetes.io/component: helm-operator
{{ include "oaas-namespace.matchLabels" . }}
{{- end -}}
