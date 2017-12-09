$(document).ready(function () {
    setInterval(function () {
        $('.status-container').load('/sites/ping');

    }, 1000);
});