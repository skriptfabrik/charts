{{/*
Expand the name of the chart.
*/}}
{{- define "directus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "directus.fullname" -}}
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
{{- define "directus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "directus.labels" -}}
helm.sh/chart: {{ include "directus.chart" . }}
{{ include "directus.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "directus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "directus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "directus.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "directus.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "directus.secretName" -}}
{{- default (include "directus.fullname" .) .Values.directus.extra.existingSecret }}
{{- end }}

{{/*
Create the public URL
*/}}
{{- define "directus.publicURL" -}}
{{- $basePath := (trimPrefix "/" (default "/" .Values.directus.general.basePath)) }}
{{- if .Values.ingress.enabled }}
{{- $host := (index .Values.ingress.hosts 0).host }}
{{- if .Values.ingress.tls }}
{{- printf "https://%s/%s" $host $basePath }}
{{- else }}
{{- printf "http://%s/%s" $host $basePath }}
{{- end }}
{{- else }}
{{- print "/" $basePath }}
{{- end }}
{{- end }}

{{/*
Create the root redirect
*/}}
{{- define "directus.rootRedirect" -}}
{{- $basePath := (trimPrefix "/" (default "/" .Values.directus.general.basePath)) }}
{{- if .Values.ingress.enabled }}
{{- $host := (index .Values.ingress.hosts 0).host }}
{{- if .Values.ingress.tls }}
{{- printf "https://%s/%s/admin" $host (trimSuffix "/" $basePath) }}
{{- else }}
{{- printf "http://%s/%s/admin" $host (trimSuffix "/" $basePath) }}
{{- end }}
{{- else }}
{{- print "./admin" }}
{{- end }}
{{- end }}
