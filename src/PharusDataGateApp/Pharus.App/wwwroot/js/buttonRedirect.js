﻿function buttonRedirect() {
    const btn = document.getElementById('btnRedirect');

    btn.addEventListener('click', redirect);

    function redirect() {
        window.location.href = 'All';
    }
}