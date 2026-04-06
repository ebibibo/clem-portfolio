@echo off
setlocal enabledelayedexpansion

REM =========================
REM STEP 1: RENAME IMAGES
REM =========================
cd images
set count=1
for %%f in (*.jpg *.jpeg *.png *.gif) do (
    set "ext=%%~xf"
    ren "%%f" "art!count!!ext!" >nul 2>&1
    set /a count+=1
)
cd ..
echo Renamed !count!-1 images.

REM =========================
REM STEP 2: REMOVE OLD ARRAY IN script.js
REM =========================
set "skip=0"
(for /f "usebackq delims=" %%l in ("script.js") do (
    set "line=%%l"
    echo !line! | findstr /c:"const galleryImages" >nul
    if !errorlevel! == 0 set skip=1

    if !skip! == 0 echo !line!

    echo !line! | findstr /c:"];" >nul
    if !errorlevel! == 0 if !skip! == 1 set skip=0
)) > script_clean.js
move /y script_clean.js script.js >nul

REM =========================
REM STEP 3: CREATE NEW ARRAY AT TOP
REM =========================
(
echo const galleryImages = [
set i=0
for %%f in (images\art*) do (
    set /a i+=1
    set "line=    "%%~nxf""
    REM Add comma if not last image
    if %%f neq (images\art%i%*) set "line=!line!,"
    echo !line!
)
echo ];
echo.
type script.js
) > script_temp.js
move /y script_temp.js script.js >nul
echo script.js updated with new galleryImages array.

REM =========================
REM STEP 4: COMMIT & PUSH
REM =========================
git add images script.js >nul
git commit -m "Update gallery" >nul 2>&1
git push >nul 2>&1

echo Gallery updated, committed, and pushed!
pause