@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: %~nx0 {replacement_string}
    exit /b 1
)

set "replacement_string=%~1"

set "input_file=input.txt"
set "output_file=output.txt"

if not exist "%input_file%" (
    echo Error: Input file "%input_file%" not found.
    exit /b 1
)

if exist "%output_file%" del "%output_file%"

for /f "usebackq delims=" %%A in ("%input_file%") do (
    set "line=%%A"
    set "line=!line:{EndpointIDString}=%replacement_string%!"
    echo !line! >> "%output_file%"
)

echo Replacement complete. Output written to "%output_file%".
