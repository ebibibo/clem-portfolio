@echo off
setlocal enabledelayedexpansion

REM --- Step 1: Set variables ---
set "IMAGES_FOLDER=images"
set "SCRIPT_FILE=script.js"

REM --- Step 2: Remove old galleryImages array ---
REM Remove lines between "const galleryImages = [" and the next "];"
set "inside=0"
(
for /f "usebackq delims=" %%a in ("%SCRIPT_FILE%") do (
    set "line=%%a"
    if "!line!"=="const galleryImages = [" set inside=1
    if !inside! EQU 0 echo %%a
    if "!line!"=="];"
        if !inside! EQU 1 set inside=0
)
) > temp_script.js
move /y temp_script.js "%SCRIPT_FILE%"

REM --- Step 3: Rename images ---
set /a COUNT=1
for %%F in (%IMAGES_FOLDER%\*) do (
    ren "%%F" "art!COUNT!.png"
    set /a COUNT+=1
)

REM --- Step 4: Append new galleryImages array ---
(
echo const galleryImages = [
for /L %%i in (1,1,!COUNT!-1) do (
    if %%i LSS !COUNT!-1 (
        echo     "art%%i.png",
    ) else (
        echo     "art%%i.png"
    )
)
echo ];
) >> "%SCRIPT_FILE%"

REM --- Step 5: Git add, commit, push ---
git add "%SCRIPT_FILE%" "%IMAGES_FOLDER%"
git commit -m "Update Gallery"
git push

echo Gallery updated and pushed!
pause