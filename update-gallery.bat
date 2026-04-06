@echo off
setlocal enabledelayedexpansion

REM =========================
REM CONFIG
REM =========================
set maxImages=20
set maxSize=5242880   REM 5MB

REM =========================
REM STEP 1: RENAME IMAGES
REM =========================
cd images

set count=1
for %%f in (*.jpg *.jpeg *.png *.gif) do (
    for %%I in ("%%f") do set size=%%~zI

    if !size! LEQ %maxSize% (
        if !count! LEQ %maxImages% (
            set "ext=%%~xf"
            ren "%%f" "art!count!!ext!"
            set /a count+=1
        ) else (
            echo Skipping %%f (max images reached)
        )
    ) else (
        echo Skipping %%f (too large)
    )
)

cd ..

echo Renamed !count!-1 images.

REM =========================
REM STEP 2: REMOVE OLD ARRAY
REM =========================
REM Delete lines starting with "const galleryImages" and up to the closing "];"
(for /f "delims=" %%l in ('findstr /n "^" script.js') do (
    set "line=%%l"
    REM Get line number
    for /f "tokens=1* delims=:" %%a in ("%%l") do set "ln=%%a" & set "txt=%%b"
    
    REM Check if line contains "const galleryImages"
    echo !txt! | findstr /c:"const galleryImages" >nul
    if errorlevel 1 (
        REM Not the start of array, print
        echo !txt!>>script_clean.js
    ) else (
        REM Skip lines until we find "];"
        set skip=1
        :skiploop
        set /p nextLine= <&0
        echo !nextLine! | findstr /c:"];">nul
        if not errorlevel 0 goto skiploop
    )
))

move /y script_clean.js script.js

REM =========================
REM STEP 3: WRITE NEW ARRAY
REM =========================
(
    echo const galleryImages = [
    set i=1
    for %%f in (images\art*) do (
        if !i! LEQ %maxImages% (
            echo     "%%~nxf",
            set /a i+=1
        )
    )
    echo ];
    echo.
    type script.js
) > script_temp.js

move /Y script_temp.js script.js

echo script.js updated.

REM =========================
REM STEP 4: GIT PUSH
REM =========================
git add images script.js
git commit -m "Update gallery"
git push

echo.
echo Gallery updated, committed, and pushed successfully!
pause