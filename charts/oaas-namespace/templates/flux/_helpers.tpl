{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oaas-namespace.flux.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name "flux" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name "flux" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
flux common labels
*/}}
{{- define "oaas-namespace.flux.labels" -}}
{{ include "oaas-namespace.flux.matchLabels" . }}
{{ include "oaas-namespace.metaLabels" . }}
{{- end -}}

{{/*
flux selector labels
*/}}
{{- define "oaas-namespace.flux.matchLabels" -}}
app.kubernetes.io/component: flux
{{ include "oaas-namespace.matchLabels" . }}
{{- end -}}

{{/*
flux service account name
*/}}
{{- define "oaas-namespace.flux.serviceAccountName" -}}
{{ include "oaas-namespace.flux.fullname" . }}
{{- end -}}
