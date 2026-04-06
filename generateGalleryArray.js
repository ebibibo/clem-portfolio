const fs = require('fs');
const path = require('path');

const imagesFolder = path.join(__dirname, 'images');
const scriptFile = path.join(__dirname, 'script.js');

let imageFiles = [];
try {
    imageFiles = fs.readdirSync(imagesFolder)
        .filter(file => {
            const ext = path.extname(file).toLowerCase();
            return ['.jpg', '.jpeg', '.png', '.gif'].includes(ext);
        });
} catch (err) {
    console.error('Error reading images folder:', err);
}

// Build JS array string
const arrayString = `const galleryImages = [\n${imageFiles.map(f => `    "${f}"`).join(',\n')}\n];\n`;

// Read existing script.js
let scriptContent = '';
try {
    scriptContent = fs.readFileSync(scriptFile, 'utf8');
} catch (err) {
    console.error('Error reading script.js:', err);
    process.exit(1);
}

// Replace or insert galleryImages array
const newContent = scriptContent.replace(/const galleryImages = \[[\s\S]*?\];/, arrayString);

// If no existing array, prepend
const finalContent = newContent.includes('const galleryImages =') ? newContent : arrayString + scriptContent;

// Write updated script.js
try {
    fs.writeFileSync(scriptFile, finalContent, 'utf8');
    console.log('script.js updated with', imageFiles.length, 'images.');
} catch (err) {
    console.error('Error writing script.js:', err);
    process.exit(1);
}