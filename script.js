const galleryImages = [
    "art1.png",
    "art2.png",
];

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
ECHO is off.
function openFullscreen(src) {
    // Create overlay
    overlay.classList.add('overlay');
ECHO is off.
    // Create fullscreen image
    bigImg.src = src;
    bigImg.classList.add('overlay-img');
ECHO is off.
    // Click on image → zoom toggle
    bigImg.addEventListener('click', (e) => {
        e.stopPropagation(); // Prevent closing
        bigImg.classList.toggle('zoomed');
    });
ECHO is off.
    // Click outside image → close overlay
    overlay.addEventListener('click', () => {
        overlay.remove();
    });
ECHO is off.
    overlay.appendChild(bigImg);
    document.body.appendChild(overlay);
}
