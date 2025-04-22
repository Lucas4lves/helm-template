{{/* vim: set filetype=mustache: */}}

{{/*
Este bloco define o nome do recurso que está sendo criado, que é usado para gerar o nome do deployment, do serviço, etc.
*/}}
{{- define "{{ .Values.nameDeployment }}.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Este bloco define o nome totalmente qualificado do recurso, que é usado para gerar o nome dos objetos Kubernetes.
*/}}
{{- define "{{ .Values.nameDeployment }}.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Este bloco define o nome e a versão do Chart como usados ​​pela etiqueta do Chart.
*/}}

{{- define "{{ .Values.nameDeployment }}.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Novo Selector e labels vs 2.0
*/}}

{{/*
Este bloco define as etiquetas comuns que são adicionadas a todos os recursos criados pelo Chart.
*/}}
{{- define "{{ .Values.nameDeployment }}.labels" -}}
{{ include "{{ .Values.nameDeployment }}.selectorLabels" . }}
version: {{ .Values.version }}
{{- end -}}


{{/*
Este bloco define as etiquetas que são usadas para selecionar recursos específicos com o seletor do Kubernetes.
*/}}
{{- define "{{ .Values.nameDeployment }}.selectorLabels" -}}
app: {{ .Values.nameDeployment }}
{{- end -}}


{{/*
Este bloco define o nome do app dentro da matchExpressions.values do affinity
*/}}
{{- define "{{ .Values.nameDeployment }}.affinity" -}}
- {{.Values.nameDeployment}}
{{- end -}}