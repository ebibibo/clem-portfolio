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
REM STEP 2: CLEAN OLD ARRAY
REM =========================
findstr /v "const galleryImages" script.js > script_clean.js
move /Y script_clean.js script.js

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