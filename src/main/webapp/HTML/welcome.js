/**
 * 
 */
document.addEventListener('DOMContentLoaded', function () {

    if (!userName || userName.trim() === "") {
        return;
    }

    const userInitial = userName.charAt(0).toUpperCase();

    const navAvatar = document.getElementById('nav-avatar');
    const navName = document.getElementById('nav-name');
    const welcomeName = document.getElementById('welcome-name');

    if (navAvatar) {
        navAvatar.textContent = userInitial;
    }

    if (navName) {
        navName.textContent = userName.split(' ')[0];
    }

    if (welcomeName) {
        welcomeName.textContent = userName.split(' ')[0];
    }
});