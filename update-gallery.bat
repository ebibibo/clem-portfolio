@echo off
setlocal enabledelayedexpansion

REM Step 1: Rename images in the images folder
cd images

set count=1
for %%f in (*.jpg *.jpeg *.png *.gif) do (
    set "ext=%%~xf"
    ren "%%f" "art!count!!ext!"
    set /a count+=1
)
echo Renamed !count!-1 images.
cd ..

REM Step 2: Update script.js with new galleryImages array
set scriptFile=script.js
set imagesFolder=images

REM Initialize array content
set arrayContent=const galleryImages = [

REM Loop through renamed files to generate JS array
set i=1
for %%f in (%imagesFolder%\art*) do (
    set arrayContent=!arrayContent!"%%~nxf"
    if not %%f==%imagesFolder%\art!count!-1%%~xf set arrayContent=!arrayContent!,
)
set arrayContent=!arrayContent!];

REM Read script.js into temp file
set tempFile=script_temp.js
(
    echo !arrayContent!
    type %scriptFile%
) > %tempFile%

REM Replace script.js with updated version
move /Y %tempFile% %scriptFile%
echo script.js updated with galleryImages array.

REM Step 3: Git add, commit, push
git add %imagesFolder% %scriptFile%
git commit -m "Update gallery"
git push

echo Gallery updated, committed, and pushed successfully!
pause