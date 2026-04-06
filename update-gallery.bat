@echo off
REM Regenerate gallery.json
node generateGalleryJson.js

REM Add gallery.json and commit
git add gallery.json
git commit -m "Update gallery"

REM Push to GitHub
git push

echo.
echo Gallery updated and pushed successfully!
pause