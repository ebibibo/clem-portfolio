const fs = require('fs');
const path = require('path');

function generateGalleryJson() {
    const imagesFolder = path.join(__dirname, 'images');      // Path to images folder
    const galleryJsonPath = path.join(__dirname, 'gallery.json'); // Path to gallery.json

    let imageFiles = [];

    try {
        imageFiles = fs.readdirSync(imagesFolder)
            .filter(file => {
                const ext = path.extname(file).toLowerCase();
                return ['.jpg', '.jpeg', '.png', '.gif', '.webp'].includes(ext);
            });
    } catch (err) {
        console.error("Error reading images folder:", err);
        return;
    }

    if (imageFiles.length === 0) {
        console.warn("No images found in the images folder!");
    } else {
        console.log("Found images:", imageFiles.join(', '));
    }

    const galleryData = { images: imageFiles };

    try {
        fs.writeFileSync(galleryJsonPath, JSON.stringify(galleryData, null, 2));
        console.log(`gallery.json updated with ${imageFiles.length} image(s).`);
    } catch (err) {
        console.error("Error writing gallery.json:", err);
    }
}

// Run the function
generateGalleryJson();