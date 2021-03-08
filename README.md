lvs-textfile-collector
======================

`bash /usr/local/bin/lvs.sh | sponge /etc/node_exporter/collector/lvs.prom`

```
# HELP lvs_cache_dirty_blocks cache_dirty_blocks
# TYPE lvs_cache_dirty_blocks gauge
lvs_cache_dirty_blocks{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 0
lvs_cache_dirty_blocks{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 0
# HELP lvs_cache_read_hits cache_read_hits
# TYPE lvs_cache_read_hits gauge
lvs_cache_read_hits{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 553236
lvs_cache_read_hits{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 553236
# HELP lvs_cache_read_misses cache_read_misses
# TYPE lvs_cache_read_misses gauge
lvs_cache_read_misses{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 1.671247e+06
lvs_cache_read_misses{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 1.671247e+06
# HELP lvs_cache_total_blocks cache_total_blocks
# TYPE lvs_cache_total_blocks gauge
lvs_cache_total_blocks{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 943500
lvs_cache_total_blocks{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 943500
# HELP lvs_cache_used_blocks cache_used_blocks
# TYPE lvs_cache_used_blocks gauge
lvs_cache_used_blocks{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 176367
lvs_cache_used_blocks{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 176367
# HELP lvs_cache_write_hits cache_write_hits
# TYPE lvs_cache_write_hits gauge
lvs_cache_write_hits{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 189323
lvs_cache_write_hits{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 189323
# HELP lvs_cache_write_misses cache_write_misses
# TYPE lvs_cache_write_misses gauge
lvs_cache_write_misses{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 1.747418e+06
lvs_cache_write_misses{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 1.747418e+06
# HELP lvs_copy_percent copy_percent
# TYPE lvs_copy_percent gauge
lvs_copy_percent{devices="cachepool_cpool_cdata(0)",lv_name="[cachepool_cpool]",segtype="cache-pool",vg_name="vg_minio"} 0
lvs_copy_percent{devices="lv_minio_corig(0)",lv_name="lv_minio",segtype="cache",vg_name="vg_minio"} 0
```
