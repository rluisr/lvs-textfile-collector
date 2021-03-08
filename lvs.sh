#!/bin/bash
# Script informed by the collectd monitoring script for lvs (using lvs)
# by rluisr
# git: https://github.com/rluisr/lvs-textfile-collector

set -eu

function get_metrics() {
  local json="$1"
  local attr="$2"
  local value="$(echo "${json}" | jq -r ."${attr}" | sed -e "s/G//g")"
  local lv_name="$(echo ${json} | jq -r .lv_name)"
  local vg_name="$(echo ${json} | jq -r .vg_name)"
  local devices="$(echo ${json} | jq -r .devices)"
  local segtype="$(echo ${json} | jq -r .segtype)"

  if [ "$(is_null "${value}")" == "ng" ]; then
    echo "lvs_${attr}{lv_name=\"${lv_name}\",vg_name=\"${vg_name}\",devices=\"${devices}\",segtype=\"${segtype}\"} ${value}"
  fi
}

function is_null() {
  local value="$1"

  if [ "${value}" == "" ]; then
    echo "ok"
  else
    echo "ng"
  fi
}

lv_reports=$(/usr/sbin/lvs -a -o +devices,cache_total_blocks,cache_used_blocks,cache_dirty_blocks,cache_read_hits,cache_read_misses,cache_write_hits,cache_write_misses,segtype --reportformat json --units G | jq .report[].lv)
lv_report_length=$(echo "${lv_reports}" | jq length)

for i in $(seq 0 $(($lv_report_length - 1))); do
  json=$(echo "${lv_reports}" | jq .[$i])

  arr_lv_size+=("$(get_metrics "${json}" "lv_size")")
  arr_data_percent+=("$(get_metrics "${json}" "data_percent")")
  arr_metadata_percent+=("$(get_metrics "${json}" "metadata_percent")")
  arr_copy_percent+=("$(get_metrics "${json}" "copy_percent")")
  arr_cache_total_blocks+=("$(get_metrics "${json}" "cache_total_blocks")")
  arr_cache_used_blocks+=("$(get_metrics "${json}" "cache_used_blocks")")
  arr_cache_dirty_blocks+=("$(get_metrics "${json}" "cache_dirty_blocks")")
  arr_cache_read_hits+=("$(get_metrics "${json}" "cache_read_hits")")
  arr_cache_read_misses+=("$(get_metrics "${json}" "cache_read_misses")")
  arr_cache_write_hits+=("$(get_metrics "${json}" "cache_write_hits")")
  arr_cache_write_misses+=("$(get_metrics "${json}" "cache_write_misses")")
done

body="$(echo -e '# HELP lvs_lv_size lv_size in G\n# TYPE lvs_lv_size gauge')"
for lv_size in "${arr_lv_size[@]}"; do
  body+=$(echo -e "\n${lv_size}\n")
done

body="$(echo -e '# HELP lvs_data_percent data_percent\n# TYPE lvs_data_percent gauge')"
for data_percent in "${arr_data_percent[@]}"; do
  body+=$(echo -e "\n${data_percent}\n")
done

body="$(echo -e '# HELP lvs_metadata_percent metadata_percent\n# TYPE lvs_metadata_percent gauge')"
for metadata_percent in "${arr_metadata_percent[@]}"; do
  body+=$(echo -e "\n${metadata_percent}\n")
done

body="$(echo -e '# HELP lvs_copy_percent copy_percent\n# TYPE lvs_copy_percent gauge')"
for copy_percent in "${arr_copy_percent[@]}"; do
  body+=$(echo -e "\n${copy_percent}\n")
done

body+="$(echo -e '\n# HELP lvs_cache_total_blocks cache_total_blocks\n# TYPE lvs_cache_total_blocks gauge')"
for cache_total_blocks in "${arr_cache_total_blocks[@]}"; do
  body+=$(echo -e "\n${cache_total_blocks}\n")
done

body+="$(echo -e '\n# HELP lvs_cache_used_blocks cache_used_blocks\n# TYPE lvs_cache_used_blocks gauge')"
for cache_used_blocks in "${arr_cache_used_blocks[@]}"; do
  body+=$(echo -e "\n${cache_used_blocks}\n")
done

body+="$(echo -e '\n# HELP lvs_cache_dirty_blocks cache_dirty_blocks\n# TYPE lvs_cache_dirty_blocks gauge')"
for cache_dirty_blocks in "${arr_cache_dirty_blocks[@]}"; do
  body+=$(echo -e "\n${cache_dirty_blocks}\n")
done

body+="$(echo -e '\n# HELP lvs_cache_read_hits cache_read_hits\n# TYPE lvs_cache_read_hits gauge')"
for cache_read_hits in "${arr_cache_read_hits[@]}"; do
  body+=$(echo -e "\n${cache_read_hits}\n")
done

body+="$(echo -e '\n# HELP lvs_cache_read_misses cache_read_misses\n# TYPE lvs_cache_read_misses gauge')"
for cache_read_misses in "${arr_cache_read_misses[@]}"; do
  body+=$(echo -e "\n${cache_read_misses}\n")
done

body+="$(echo -e '\n# HELP lvs_cache_write_hits cache_write_hits\n# TYPE lvs_cache_write_hits gauge')"
for cache_write_hits in "${arr_cache_write_hits[@]}"; do
  body+=$(echo -e "\n${cache_write_hits}\n")
done

body+="$(echo -e '\n# HELP lvs_cache_write_misses cache_write_misses\n# TYPE lvs_cache_write_misses gauge')"
for cache_write_misses in "${arr_cache_write_misses[@]}"; do
  body+=$(echo -e "\n${cache_write_misses}\n")
done

echo "${body}"
