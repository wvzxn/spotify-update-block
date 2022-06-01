@echo off
if not "%1"=="am_admin" ( powershell start -verb runas '%0' 'am_admin "%~1" "%~2"' & exit )
set "_PS1_COMMAND=& %USERPROFILE%\Desktop\1.ps1"
start "mhddos" powershell -executionpolicy bypass -command "%_PS1_COMMAND%"
exit