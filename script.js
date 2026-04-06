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
    overlay.classList.add('overlay');
    bigImg.src = src;
    bigImg.classList.add('overlay-img');
    let zoomed = false;
    bigImg.addEventListener('click', (e) => {
        e.stopPropagation();
        if (zoomed) {
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
