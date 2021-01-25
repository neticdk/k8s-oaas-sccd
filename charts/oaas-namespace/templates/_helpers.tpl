{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "labels" -}}
{{ include "metaLabels" . }}
{{ include "matchLabels" . }}
{{- end }}

{{/*
Meta labels
*/}}
{{- define "metaLabels" -}}
helm.sh/chart: {{ include "chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "matchLabels" -}}
app.kubernetes.io/name: {{ include "name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "netic.flux.fullname" -}}
{{- if .Values.flux.fullnameOverride }}
{{- .Values.flux.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- $fluxName := default "flux" .Values.flux.name }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name $fluxName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name $fluxName | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create cluster wide name (includes the current namespace)
*/}}
{{- define "netic.flux.cluster" -}}
{{- $fluxName := default "flux" .Values.flux.name }}
{{- printf "%s-%s-%s" .Release.Namespace .Release.Name $fluxName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create cluster wide name for psp (includes the current namespace)
*/}}
{{- define "netic.flux.cluster.psp" -}}
{{- $fluxName := default "flux" .Values.flux.name }}
{{- printf "%s-%s-%s-psp" .Release.Namespace .Release.Name $fluxName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
flux common labels
*/}}
{{- define "netic.flux.labels" -}}
{{ include "netic.flux.matchLabels" . }}
{{ include "metaLabels" . }}
{{- end -}}

{{/*
flux selector labels
*/}}
{{- define "netic.flux.matchLabels" -}}
app.kubernetes.io/component: flux
{{ include "matchLabels" . }}
{{- end -}}

{{/*
flux service account name
*/}}
{{- define "netic.flux.serviceAccountName" -}}
{{ .Values.flux.serviceAccount.name }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "netic.helmop.fullname" -}}
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
Create cluster wide name (includes the current namespace)
*/}}
{{- define "netic.helmop.cluster" -}}
{{- $helmopName := default "helmop" (index .Values "helm-operator" "name") }}
{{- printf "%s-%s-%s" .Release.Namespace .Release.Name $helmopName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create cluster wide name for psp (includes the current namespace)
*/}}
{{- define "netic.helmop.cluster.psp" -}}
{{- $helmopName := default "helmop" (index .Values "helm-operator" "name") }}
{{- printf "%s-%s-%s-psp" .Release.Namespace .Release.Name $helmopName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
helm operator common labels
*/}}
{{- define "netic.helmop.labels" -}}
{{ include "netic.helmop.matchLabels" . }}
{{ include "metaLabels" . }}
{{- end -}}

{{/*
helm operator selector labels
*/}}
{{- define "netic.helmop.matchLabels" -}}
app.kubernetes.io/component: helm-operator
{{ include "matchLabels" . }}
{{- end -}}

{{/*
helm operator service account name
*/}}
{{- define "netic.helmop.serviceAccountName" -}}
{{ index .Values "helm-operator" "serviceAccount" "name" }}
{{- end -}}
