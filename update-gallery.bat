@echo off
REM =============================
REM Update Gallery Script
REM =============================
pause

REM --- Variables ---
set "IMAGES_FOLDER=images"
set "SCRIPT_FILE=script.js"
set COUNT=1

REM --- Step 1: Remove old galleryImages array ---
echo Removing old galleryImages array from %SCRIPT_FILE%...
setlocal enabledelayedexpansion
(for /f "usebackq delims=" %%a in ("%SCRIPT_FILE%") do (
    set "line=%%a"
    if "!line!"=="const galleryImages = [" (
        set inside=1
    )
    if not defined inside echo %%a
    if "!line!"=="];" (
        set inside=
    )
)) > temp_script.js
move /y temp_script.js "%SCRIPT_FILE%"
endlocal

REM --- Step 2: Rename images ---
echo Renaming images in %IMAGES_FOLDER%...
for %%F in (%IMAGES_FOLDER%\*) do (
    echo Renaming %%F to art%COUNT%.png
    ren "%%F" "art%COUNT%.png"
    set /a COUNT+=1
)

REM --- Step 3: Append new galleryImages array ---
echo Adding new galleryImages array to %SCRIPT_FILE%...
(
echo const galleryImages = [
for /L %%i in (1,1,%COUNT%-1) do (
    if %%i LSS %COUNT%-1 (
        echo     "art%%i.png",
    ) else (
        echo     "art%%i.png"
    )
)
echo ];
) >> "%SCRIPT_FILE%"

REM --- Step 4: Git add, commit, push ---
echo Adding files to git...
git add "%SCRIPT_FILE%" "%IMAGES_FOLDER%"
echo Committing changes...
git commit -m "Update Gallery"
echo Pushing to origin...
git push

echo Done! Press any key to close.
pause