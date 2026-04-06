@echo off
setlocal enabledelayedexpansion

REM ===========================
REM 1. Variables
REM ===========================
set IMAGES_DIR=images
set SCRIPT_FILE=script.js
set COUNT=1

REM ===========================
REM 2. Delete old art files from script.js
REM ===========================
echo Removing old galleryImages array from %SCRIPT_FILE%...
powershell -Command "(Get-Content %SCRIPT_FILE%) -replace 'const galleryImages = \[.*?\];', '' | Set-Content %SCRIPT_FILE%"

REM ===========================
REM 3. Rename images in images folder
REM ===========================
echo Renaming images in %IMAGES_DIR%...
for %%f in (%IMAGES_DIR%\*) do (
    set EXT=%%~xf
    ren "%%f" "art!COUNT!!EXT!"
    echo Renamed %%f to art!COUNT!!EXT!
    set /a COUNT+=1
)

REM ===========================
REM 4. Rebuild galleryImages array in script.js
REM ===========================
echo Updating %SCRIPT_FILE% with new galleryImages array...
(
    echo const galleryImages = [
)
for %%f in (%IMAGES_DIR%\*) do (
    echo    "%%~nxf",
)
(
    echo ];
) >> temp_array.txt

REM Append temp_array.txt to script.js
type temp_array.txt >> %SCRIPT_FILE%
del temp_array.txt

REM ===========================
REM 5. Git add, commit, push
REM ===========================
git add .
git commit -m "Update Gallery"
git push

echo Gallery updated, committed, and pushed.
pause