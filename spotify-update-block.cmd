::         Name: Spotify Update Block v1.0
::       Author: wvzxn // https://github.com/wvzxn/
::  Description: Simple script that will help you block Spotify updates.
::               It acts as both installer and uninstaller.

@echo off
net session >nul 2>&1
if %errorLevel% NEQ 0 ( echo Run as Administrator required. & pause & exit )
setlocal EnableDelayedExpansion
set "d=%localappdata%\Spotify"
set "n=spotify-update-block"
for /f "usebackq delims=" %%A in (` findstr /b /c:"::  " "%~f0" `) do echo %%A
echo.
if not exist "!d!\.!n!" ( call:block ) else ( call:unblock )
pause
exit

:block
echo Press ^[Y^] to install
call:userPrompt Y
if not exist "!d!\Update" ( md "!d!\Update" )
icacls "!d!\Update" /deny *S-1-1-0:F /q
echo !n! installed>> "!d!\.!n!"
attrib +r +h "!d!\.!n!" >nul 2>&1 & icacls "!d!\.!n!" /deny *S-1-1-0:F >nul 2>&1
exit /b

:unblock
echo Press ^[Enter^] to uninstall
call:userPrompt Enter
icacls "!d!\Update" /reset /q
icacls "!d!\.!n!" /reset >nul 2>&1 & attrib -r -h "!d!\.!n!" >nul 2>&1
del /q /f "!d!\.!n!"
exit /b

:userPrompt
for /f "usebackq delims=" %%K in (` powershell "[Console]::ReadKey($true).Key" `) do if not "%%K"=="%*" ( exit )
exit /b