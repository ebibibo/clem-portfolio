const galleryImages = ["art1.png","art2.png",];
const galleryImages = ["art1.png","art2.png",];
// script.js

window.addEventListener('DOMContentLoaded', () => {
    const galleryContainer = document.getElementById('gallery-container');
    galleryContainer.innerHTML = '';

    // Array of images (will match renamed files)
    const galleryImages = [
        "art1.png",
        "art2.png",
        "art3.png"
        // Add more if you have more images
    ];

    galleryImages.forEach(filename => {
        const img = document.createElement('img');
        img.src = './images/' + filename;
        img.alt = filename;
        img.classList.add('gallery-img');
        galleryContainer.appendChild(img);
    });

    console.log(`Loaded ${galleryImages.length} images into gallery.`);
});