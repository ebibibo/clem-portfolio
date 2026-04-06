const galleryImages = ["art1.png","art2.png"];
// script.js
window.addEventListener('DOMContentLoaded', () => {
    const galleryContainer = document.getElementById('gallery-container');
    galleryContainer.innerHTML = '';
    galleryImages.forEach(filename => {
        const img = document.createElement('img');
        img.src = './images/' + filename;
        img.alt = filename;
        img.classList.add('gallery-img');

        img.addEventListener('click', () => {
            openFullscreen(img.src);
        });

        galleryContainer.appendChild(img);
    });
    console.log(`Loaded ${galleryImages.length} images into gallery.`);
});

function openFullscreen(src) {
    const overlay = document.createElement('div');
    overlay.classList.add('overlay');

    const bigImg = document.createElement('img');
    bigImg.src = src;
    bigImg.classList.add('overlay-img');

    let zoomed = false;

    bigImg.addEventListener('click', (e) => {
        e.stopPropagation();

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