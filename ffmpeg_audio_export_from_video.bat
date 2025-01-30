@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Drag and drop an Video file onto this script to export.
    pause
    exit /b
)

set "input_file=%~1"
set "filename=%~n1"

echo InputFile: "%input_file%"
echo FileName: "%filename%"

set "output_format="
set /p output_format=Enter the output format (e.g., mp3, wav, flac): 

if "%output_format%"=="" (
    echo No format entered. Export canceled.
    pause
    exit /b
)

set "output_file=%~dp1%filename%.%output_format%"

echo OutputFile: "%output_file%"

where ffmpeg >nul 2>nul
if errorlevel 1 (
    echo ffmpeg is not found. Make sure it is installed and added to PATH.
    pause
    exit /b
)

ffmpeg -i "%input_file%" -q:a 0 -map a "%output_file%"

if not exist "%output_file%" (
    echo Export failed.
    pause
    exit /b
)

echo Export successful. Output file: "%output_file%"
pause
