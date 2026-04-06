// script.js
window.addEventListener('DOMContentLoaded', () => {
    const galleryContainer = document.getElementById('gallery-container');
    galleryContainer.innerHTML = '';
    galleryImages.forEach(filename => {
        const img = document.createElement('img');
        img.src = './images/' + filename;
        img.alt = filename;
        img.classList.add('gallery-img');
        // Click on image → open fullscreen
        img.addEventListener('click', () => {
            openFullscreen(img.src);
        });
        galleryContainer.appendChild(img);
    });
});
function openFullscreen(src) {
    let zoomed = false; // Track zoom state
    const overlay = document.createElement('div');
    overlay.classList.add('overlay');
    // Create fullscreen image
    const bigImg = document.createElement('img');
    bigImg.src = src;
    bigImg.classList.add('overlay-img');
    // Click on image to toggle zoom
    bigImg.addEventListener('click', (e) => {
        e.stopPropagation(); // Prevent closing
        if (!zoomed) {
            bigImg.style.transform = 'scale(1.5)';
            zoomed = true;
        } else {
            bigImg.style.transform = 'scale(1)';
            zoomed = false;
        }
    });
    overlay.addEventListener('click', () => {
        overlay.remove();
    });
    overlay.appendChild(bigImg);
    document.body.appendChild(overlay);
}
const galleryImages = [
    "art1.png",
    "art2.png",
    "art3.png",
    "art4.png",
];
