AOS.init({
  once: true,
});

const navToggle = document.getElementById("nav-toggle");
const navLinks = document.getElementById("main-nav");
navToggle.addEventListener("click", () => {
  navLinks.classList.toggle("show");
});

document.getElementById("year").textContent = new Date().getFullYear();
