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
    echo {%endpoint_id%}
) else (
    echo {%endpoint_id%} not found
    exit /b 1
)

set "input_file=FxProperties-base.txt"
set "output_file=FxProperties.reg"

if not exist "%input_file%" (
    echo Error: Input file "%input_file%" not found.
    exit /b 1
)

if exist "%output_file%" del "%output_file%"

powershell -Command "Get-Content %input_file% | ForEach-Object { $_ -replace '{EndpointIDString}', '%endpoint_id%' } | Set-Content %output_file%"

echo Replacement complete. Output written to "%output_file%".

endlocal
