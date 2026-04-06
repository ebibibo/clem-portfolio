const galleryImages = [
    "IMG_1333.png",
    "okeh.png"
];
// script.js

// Wait until the DOM is fully loaded
window.addEventListener('DOMContentLoaded', loadGallery);

async function loadGallery() {
    const galleryContainer = document.getElementById('gallery-container');

    try {
        // Fetch gallery.json relative to HTML
        const response = await fetch('./gallery.json');
        if (!response.ok) throw new Error('Could not fetch gallery.json');

        const data = await response.json();

        // Clear container first
        galleryContainer.innerHTML = '';

        // Loop through each image filename and create <img> elements
        data.images.forEach(filename => {
            const img = document.createElement('img');
            img.src = './images/' + filename; // relative path to images folder
            img.alt = filename;
            img.classList.add('gallery-img'); // optional: add CSS class
            galleryContainer.appendChild(img);
        });

        console.log(`Loaded ${data.images.length} images into gallery.`);

    } catch (error) {
        console.error('Error loading gallery:', error);
        galleryContainer.innerHTML = '<p>Could not load gallery.</p>';
    }
}