$(document).ready(function () {
    // According to the user group page will be redirected
    // TODO

    // For now, redirect to the StudentView page
    window.location.replace("StudentView.aspx?" + document.URL.split("?")[1]);

});