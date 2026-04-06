const form = document.getElementById('contactForm');

form.addEventListener('submit', async function(e) {
    e.preventDefault(); // stop default submit

    const data = new FormData(form);
    const action = form.action;

    try {
        const response = await fetch(action, {
            method: 'POST',
            body: data,
            headers: {
                'Accept': 'application/json'
            }
        });

        if (response.ok) {
            alert('Thank you! Your message has been sent.');
            form.reset();
        } else {
            alert('Oops! There was a problem sending your message.');
        }
    } catch (error) {
        alert('Oops! There was a problem sending your message.');
        console.error(error);
    }
});