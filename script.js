window.addEventListener('DOMContentLoaded', () => {
    const galleryContainer = document.getElementById('gallery-container');
    galleryContainer.innerHTML = '';

    galleryImages.forEach((filename, index) => {
        const img = document.createElement('img');
        img.src = './images/' + filename;
        img.alt = filename;
        img.classList.add('gallery-img');

        img.addEventListener('click', () => {
            openFullscreen(index);
        });

        galleryContainer.appendChild(img);
    });
});

function openFullscreen(startIndex) {
    let currentIndex = startIndex;
    let zoomed = false;

    const overlay = document.createElement('div');
    overlay.classList.add('overlay');

    const bigImg = document.createElement('img');
    bigImg.src = './images/' + galleryImages[currentIndex];
    bigImg.classList.add('overlay-img');
    overlay.appendChild(bigImg);

    // Left/Right arrows
    const leftArrow = document.createElement('div');
    leftArrow.classList.add('arrow', 'left');
    leftArrow.innerHTML = '&#10094;'; // ◀
    const rightArrow = document.createElement('div');
    rightArrow.classList.add('arrow', 'right');
    rightArrow.innerHTML = '&#10095;'; // ▶

    overlay.appendChild(leftArrow);
    overlay.appendChild(rightArrow);

    document.body.appendChild(overlay);

    // Update image function
    function showImage(index) {
        bigImg.src = './images/' + galleryImages[index];
    }

    leftArrow.addEventListener('click', (e) => {
        e.stopPropagation();
        currentIndex = (currentIndex - 1 + galleryImages.length) % galleryImages.length;
        showImage(currentIndex);
    });

    rightArrow.addEventListener('click', (e) => {
        e.stopPropagation();
        currentIndex = (currentIndex + 1) % galleryImages.length;
        showImage(currentIndex);
    });

    // Keyboard navigation
    function handleKey(e) {
        if (e.key === 'ArrowLeft') {
            currentIndex = (currentIndex - 1 + galleryImages.length) % galleryImages.length;
            showImage(currentIndex);
        } else if (e.key === 'ArrowRight') {
            currentIndex = (currentIndex + 1) % galleryImages.length;
            showImage(currentIndex);
        } else if (e.key === 'Escape') {
            closeOverlay();
        }
    }
    document.addEventListener('keydown', handleKey);

    // Click on image → toggle zoom
    bigImg.addEventListener('click', (e) => {
        e.stopPropagation();
        zoomed = !zoomed;
        bigImg.style.transform = zoomed ? 'scale(1.5)' : 'scale(1)';
    });

    // Click outside image → close overlay
    overlay.addEventListener('click', () => {
        closeOverlay();
    });

    function closeOverlay() {
        document.removeEventListener('keydown', handleKey);
        overlay.remove();
    }
}
const galleryImages = ["art1.png", "art2.png", "art3.png", "art4.png"]; 
