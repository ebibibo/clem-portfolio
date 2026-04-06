@echo off
setlocal enabledelayedexpansion

REM Configuration
set maxImages=20
set maxSize=5242880   REM 5 MB in bytes

REM Step 1: Rename images in the images folder
cd images

set count=1
for %%f in (*.jpg *.jpeg *.png *.gif) do (
    REM Get file size in bytes
    for %%I in ("%%f") do set size=%%~zI

    if !size! LEQ %maxSize% (
        if !count! LEQ %maxImages% (
            set "ext=%%~xf"
            ren "%%f" "art!count!!ext!"
            set /a count+=1
        ) else (
            echo Skipping %%f (limit of %maxImages% reached)
        )
    ) else (
        echo Skipping %%f (too large: !size! bytes)
    )
)
cd ..

REM Step 2: Replace galleryImages array in script.js

set scriptFile=script.js
set tempFile=script_temp.js

REM Read script.js line by line
(for /f "usebackq delims=" %%L in ("%scriptFile%") do (
    set "line=%%L"
    REM Skip lines starting with const galleryImages
    echo !line! | findstr /b /c:"const galleryImages" >nul
    if errorlevel 1 (
        echo !line!
    )
)) > "%tempFile%"

REM Append the new galleryImages array at the top
set arrayContent=const galleryImages = [
set i=1
for %%f in (images\art*) do (
    if !i! LEQ %maxImages% (
        set arrayContent=!arrayContent!"%%~nxf",
        set /a i+=1
    )
)
REM Remove trailing comma and close array
set arrayContent=!arrayContent:~0,-1!];
set arrayContent=!arrayContent!

REM Combine new array + original script
(
    echo !arrayContent!
    type "%tempFile%"
) > "%scriptFile%"

del "%tempFile%"
echo script.js updated with new galleryImages array.

REM Step 3: Git add, commit, push
git add images script.js
git commit -m "Update gallery"
git push

echo Gallery updated, committed, and pushed successfully!
pause