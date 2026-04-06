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

function openFullscreen(src) {
    // Create overlay
    overlay.classList.add('overlay');

    // Create fullscreen image
    bigImg.src = src;
    bigImg.classList.add('overlay-img');

    // Click on image → zoom toggle
    bigImg.addEventListener('click', (e) => {
        e.stopPropagation(); // Prevent closing
        bigImg.classList.toggle('zoomed');
    });

    // Click outside image → close overlay
    overlay.addEventListener('click', () => {
        overlay.remove();
    });

    overlay.appendChild(bigImg);
    document.body.appendChild(overlay);
}