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
    let isDragging = false;
    let startX, startY, scrollLeft, scrollTop;

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
            bigImg.style.transform = 'scale(2)'; 
            zoomed = true;
            bigImg.style.cursor = 'grab';
        } else {
            bigImg.style.transform = 'scale(1)';
            bigImg.style.left = '0px';
            bigImg.style.top = '0px';
            zoomed = false;
            bigImg.style.cursor = 'pointer';
        }
    });

    // Drag to pan when zoomed
    bigImg.addEventListener('mousedown', (e) => {
        if (!zoomed) return;
        isDragging = true;
        startX = e.clientX;
        startY = e.clientY;
        bigImg.style.cursor = 'grabbing';
        // get current position
        const rect = bigImg.getBoundingClientRect();
        scrollLeft = rect.left;
        scrollTop = rect.top;
        e.preventDefault();
    });

    window.addEventListener('mousemove', (e) => {
        if (!isDragging) return;
        const dx = e.clientX - startX;
        const dy = e.clientY - startY;
        bigImg.style.transform = `scale(2) translate(${dx}px, ${dy}px)`;
    });

    window.addEventListener('mouseup', () => {
        if (isDragging) {
            isDragging = false;
            bigImg.style.cursor = 'grab';
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
