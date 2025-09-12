AOS.init({
  once: true,
});

const navToggle = document.getElementById("nav-toggle");
const navLinks = document.getElementById("main-nav");
navToggle.addEventListener("click", () => {
  navLinks.classList.toggle("show");
});

document.getElementById("year").textContent = new Date().getFullYear();

function initializeCountdown(daysFromNow) {
  const countdownEl = document.getElementById("countdown");
  if (!countdownEl) return;

  const target = new Date();
  target.setDate(target.getDate() + daysFromNow);

  function updateCountdown() {
    const now = new Date();
    const diff = target - now;

    if (diff <= 0) {
      countdownEl.textContent = "0d 0h 0m 0s";
      clearInterval(timer);
      return;
    }

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff / (1000 * 60 * 60)) % 24);
    const minutes = Math.floor((diff / (1000 * 60)) % 60);
    const seconds = Math.floor((diff / 1000) % 60);

    countdownEl.textContent = `${days}d ${hours}h ${minutes}m ${seconds}s`;
  }

  updateCountdown();
  const timer = setInterval(updateCountdown, 1000);
}

initializeCountdown(7);

document.querySelectorAll(".faq-question").forEach((btn) => {
  btn.addEventListener("click", () => {
    btn.parentElement.classList.toggle("open");
  });
});
