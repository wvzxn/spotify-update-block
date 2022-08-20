::: =========================================================
:::|                 _                                       |
:::|  _ ._  _ _|_ o_|_        ._  _| _._|_  _   |_ | _  _ |  |
:::| _> |_)(_) |_ | |  \/  |_||_)(_|(_| |_ (/_  |_)|(_)(_ |< |
:::|    |              /      |                              |
::: =========================================================
::: 
:: Author: wvzxn // https://github.com/wvzxn
:: Used ASCII Generator: mini // http://network-science.de/ascii
@echo off
if not "%1"=="am_admin" ( powershell start -verb runas '%0' 'am_admin "%~1" "%~2"' & exit )
if not exist "%localappdata%\Spotify\Update" ( md "%localappdata%\Spotify\Update" )
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
if exist "%localappdata%\Spotify\.spotify-update-block" ( goto:blockinstalled )
echo Press ^[Y^] to install
for /f "usebackq delims=" %%a in (` powershell "[Console]::ReadKey($true).Key" `) do set "k=%%a"
if not "%k%"=="Y" ( exit )
icacls "%localappdata%\Spotify\Update" /deny *S-1-1-0:(OI)(CI)(F) /Q 1>nul
break>"%localappdata%\Spotify\.spotify-update-block"
icacls "%localappdata%\Spotify\.spotify-update-block" /deny *S-1-1-0:F /Q 1>nul 
goto:end
:blockinstalled
echo Press ^[Enter^] to uninstall
for /f "usebackq delims=" %%a in (` powershell "[Console]::ReadKey($true).Key" `) do set "k=%%a"
if not "%k%"=="Enter" ( exit )
icacls "%localappdata%\Spotify\Update" /reset /Q 1>nul
icacls "%localappdata%\Spotify\.spotify-update-block" /reset /Q 1>nul
del /q /f "%localappdata%\Spotify\.spotify-update-block"
:end
echo Done !
timeout 2 1>nul