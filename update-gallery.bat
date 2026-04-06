@echo off
setlocal enabledelayedexpansion

REM --- Step 1: Set folders ---
set "imagesFolder=images"
set "scriptFile=script.js"

REM --- Step 2: Delete old galleryImages array in script.js ---
REM Keep everything before "const galleryImages = [" and after the closing "];"
for /f "tokens=1* delims=]" %%a in ('findstr /n "const galleryImages" "%scriptFile%"') do set "lineNumber=%%a"
if defined lineNumber (
    REM Remove old galleryImages array lines
    more +%lineNumber% "%scriptFile%" > temp.js
    move /y temp.js "%scriptFile%"
)

REM --- Step 3: Rename images to art1.png, art2.png, ... ---
set /a count=1
for %%f in (%imagesFolder%\*) do (
    set "ext=%%~xf"
    ren "%%f" "art!count!!ext!"
    set /a count+=1
)

REM --- Step 4: Update script.js with new galleryImages array ---
(
    echo const galleryImages = [
    for /L %%i in (1,1,!count!-1) do (
        if %%i lss !count!-1 (
            echo     "art%%i.png",
        ) else (
            echo     "art%%i.png"
        )
    )
    echo ];
) > galleryArray.js

REM Append gallery array to script.js
type galleryArray.js >> "%scriptFile%"
del galleryArray.js

REM --- Step 5: Git add, commit, push ---
git add "%scriptFile%" "%imagesFolder%"
git commit -m "Update Gallery"
git push

echo Gallery updated, committed, and pushed.
pause