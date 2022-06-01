@echo off
if not "%1"=="am_admin" ( powershell start -verb runas '%0' 'am_admin "%~1" "%~2"' & exit )
set "_PS1_COMMAND=[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; cls; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/wvzxn/spotify-update-block/master/script.ps1'))"
start "mhddos" powershell -executionpolicy bypass -command "%_PS1_COMMAND%"
exit