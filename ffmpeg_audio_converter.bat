@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Drag and drop an Audio file onto this script to convert.
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
    echo No format entered. Conversion canceled.
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

ffmpeg -i "%input_file%" "%output_file%"

if not exist "%output_file%" (
    echo Conversion failed.
    pause
    exit /b
)

echo Conversion successful. Output file: "%output_file%"
pause
