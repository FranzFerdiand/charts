{{- define "ix.v1.common.controller.volumes.ixVols" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- if not $vol.datasetName -}}
    {{- fail (printf "Item (%s) is set as ixVolume type, but has no Dataset Name defined" $index) -}}
  {{- end -}}
  {{- range $index, $normalizedHostPath := $root.ixVolumes -}}
    {{- if ne $vol.datasetName (base $normalizedHostPath) -}} {{/* Make sure the resolved datasetName is included in ixVolumes */}}
      {{- fail (printf "Dataset Name on item (%s) does not exist in ixVolumes list" $index) -}}
    {{- end -}}
  {{- end }}
- name: {{ $index }}
  hostPath:
    path: {{ required (printf "hostPath not set on item %s" $index) $vol.hostPath }}
  {{- with $vol.hostPathType }}
    type: {{ tpl . $root }}
  {{- end -}}
{{- end -}}
{{/* TODO: unittests */}}
