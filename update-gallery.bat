@echo off
setlocal enabledelayedexpansion

REM --- Variables ---
set imagesFolder=images
set scriptFile=script.js
set counter=1
set galleryArray=

REM --- Delete previous galleryImages array in script.js ---
for /f "delims=" %%A in ('findstr /n "const galleryImages" "%scriptFile%"') do (
    set lineNum=%%A
    set lineNum=!lineNum::=!
)
if defined lineNum (
    powershell -Command "(gc '%scriptFile%') | Where-Object {$_ -notmatch 'const galleryImages = \['} | Set-Content '%scriptFile%'"
)

REM --- Rename images and build gallery array ---
for %%F in (%imagesFolder%\*.*) do (
    set ext=%%~xF
    ren "%%F" art!counter!!ext!
    set galleryArray=!galleryArray!"art!counter!!ext!", 
    set /a counter+=1
)

REM --- Remove trailing comma and space ---
set galleryArray=[%galleryArray:~0,-2%]

REM --- Append new galleryImages array to script.js ---
echo const galleryImages = %galleryArray%; >> %scriptFile%

REM --- Git operations ---
git add .
git commit -m "Update gallery"
git push

echo Gallery updated, committed, and pushed.
pause