@echo off
REM ==========================================
REM Auto-update gallery.json and push to GitHub
REM ==========================================

REM Step 1: Regenerate gallery.json using Node.js
echo Regenerating gallery.json...
node generateGalleryJson.js
IF %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to run generateGalleryJson.js
    pause
    exit /b 1
)

REM Step 2: Add images and gallery.json to git
echo Adding files to git...
git add images gallery.json

REM Step 3: Commit changes with fixed message (skip if nothing changed)
echo Committing changes...
git commit -m "Update gallery" --allow-empty

REM Step 4: Push to GitHub
echo Pushing to GitHub...
git push
IF %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to push to GitHub. Check authentication.
    pause
    exit /b 1
)

echo ==========================================
echo Gallery updated and pushed successfully!
pause