const galleryContainer = document.getElementById('gallery-container');

// Fetch the gallery.json file
fetch('gallery.json')
    .then(response => response.json())
    .then(data => {
        galleryContainer.innerHTML = ''; // Clear any existing images

        data.images.forEach(file => {
            const img = document.createElement('img');
            img.src = 'images/' + file;  // Load image from images folder
            img.alt = file;
            img.classList.add('gallery-img'); // optional: add a class for styling
            galleryContainer.appendChild(img);
        });
    })
    .catch(err => console.error('Error loading gallery:', err));