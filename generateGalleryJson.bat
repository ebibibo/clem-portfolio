@echo off
REM 1. Generate gallery.json
echo Updating gallery...
node generateGalleryJson.js

REM 2. Stage changes in Git
echo Adding files to Git...
git add gallery.json

REM 3. Commit changes
set /p commitMessage=Enter commit message: 
git commit -m "%commitMessage%"

REM 4. Push to GitHub
echo Pushing to GitHub...
git push

REM 5. Open portfolio in browser
echo Opening portfolio in browser...
start "" "index.html"

pause