@echo off

set cur_day=%date:~7,2%
set cur_month=%date:~4,2%
set cur_year=%date:~10,4%
set cur_hour=%time:~0,2%
set cur_min=%time:~3,2%
set cur_sec=%time:~6,2%
set now=%cur_year%%cur_month%%cur_day%_time_%cur_hour%%cur_min%%cur_sec%
copy "202X.sfc" "Backups/202X_%now%.sfc"

"tools/asar.exe" 202X.asm 202X.sfc
pause