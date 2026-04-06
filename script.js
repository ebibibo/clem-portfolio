// script.js
window.addEventListener('DOMContentLoaded', () => {
    galleryContainer.innerHTML = '';
        img.src = './images/' + filename;
        img.alt = filename;
        img.classList.add('gallery-img');
        img.addEventListener('click', () => {
            openFullscreen(img.src);
        });
        galleryContainer.appendChild(img);
    });
});
function openFullscreen(src) {
    const overlay = document.createElement('div');
    overlay.classList.add('overlay');
    // Create fullscreen image
    const bigImg = document.createElement('img');
    bigImg.src = src;
    bigImg.classList.add('overlay-img');
    // Click on image → zoom toggle
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
    // Click outside image → close overlay
    overlay.addEventListener('click', () => {
        overlay.remove();
    });
    overlay.appendChild(bigImg);
    document.body.appendChild(overlay);
}
];
