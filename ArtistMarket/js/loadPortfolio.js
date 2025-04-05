window.onload = function () {
    const xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        document.getElementById("artGallery").innerHTML = this.responseText;
    }
    xhttp.open("GET", "viewportfolio.jsp", true);
    xhttp.send();
}
