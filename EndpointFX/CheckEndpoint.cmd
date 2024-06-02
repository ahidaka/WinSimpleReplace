@echo off
setlocal

if "%~1"=="" (
    echo Usage: %~nx0 {EndpointID}
    exit /b 1
)

set "endpoint_id=%~1"
set "reg_key=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\%endpoint_id%"

reg query "%reg_key%" >nul 2>&1
if %errorlevel%==0 (
    echo {%endpoint_id%} OK
) else (
    echo {%endpoint_id%} not found
)

endlocal
