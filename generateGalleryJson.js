const fs = require('fs');
const path = 'images';

// Read all files in images folder
fs.readdir(path, (err, files) => {
    if (err) {
        console.error('Error reading images folder:', err);
        return;
    }

    // Filter only image files
    const images = files.filter(file => /\.(jpg|jpeg|png|gif)$/i.test(file));

    // Write gallery.json
    fs.writeFileSync('gallery.json', JSON.stringify(images, null, 2));
    console.log('gallery.json updated with', images.length, 'images!');
});