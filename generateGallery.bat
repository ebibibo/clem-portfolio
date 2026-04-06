@echo off
REM 1. Generate gallery.json
echo Updating gallery.json...
node generateGalleryJson.js

REM 2. Stage all changes (images + gallery.json)
echo Staging changes...
git add .

REM 3. Auto-generate commit message with date and time
set commitMessage=Update gallery - %date% %time%
git commit -m "%commitMessage%"

REM 4. Push to GitHub
echo Pushing to GitHub...
git push

echo Gallery updated and pushed!
pause