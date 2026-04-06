@echo off
REM Generate gallery array in script.js
node generateGalleryArray.js

REM Add changes to git
git add script.js
git commit -m "Update gallery"
git push

echo Gallery updated, committed, and pushed successfully!
pause