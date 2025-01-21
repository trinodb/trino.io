window.onscroll = function() { scrollDetect() };

function scrollDetect() {
  let button = document.getElementById("topBtn");
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    button.style.display = "block";
  } else {
    button.style.display = "none";
  }
}

function scrollToTop() {
  document.documentElement.scrollTop = 0;
}
