@echo off
setlocal

if "%~1"=="" (
    echo Usage: %~nx0 {replacement_string}
    exit /b 1
)

set "replacement_string=%~1"

set "input_file=FxProperties-base.txt"
set "output_file=output.txt"

if not exist "%input_file%" (
    echo Error: Input file "%input_file%" not found.
    exit /b 1
)

powershell -Command "Get-Content %input_file% | ForEach-Object { $_ -replace '{EndpointIDString}', '%replacement_string%' } | Set-Content %output_file%"

echo Replacement complete. Output written to "%output_file%".
