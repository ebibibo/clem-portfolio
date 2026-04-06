@echo off
setlocal enabledelayedexpansion

REM Go to the images folder
cd images

REM Initialize counter
set count=1

REM Loop through all image files (jpg, jpeg, png, gif)
for %%f in (*.jpg *.jpeg *.png *.gif) do (
    set "ext=%%~xf"
    ren "%%f" "art!count!!ext!"
    set /a count+=1
)

echo Renamed !count!-1 images to art1, art2, ...
pause