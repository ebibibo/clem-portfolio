async function loadGallery() {
    const galleryContainer = document.getElementById('gallery-container');

    try {
        const response = await fetch('gallery.json');
        const images = await response.json();

        // Clear container first
        galleryContainer.innerHTML = '';

        images.forEach(filename => {
            const img = document.createElement('img');
            img.src = 'images/' + filename;
            img.alt = filename;
            galleryContainer.appendChild(img);
        });
    } catch (error) {
        console.error('Error loading gallery:', error);
        galleryContainer.innerHTML = '<p>Could not load gallery.</p>';
    }
}

window.addEventListener('DOMContentLoaded', loadGallery);