
// Buscador funcional
const searchInput = document.getElementById('search-input');

if (searchInput) {
  searchInput.addEventListener('input', function () {
    const query = this.value.toLowerCase();
    const cards = document.querySelectorAll('.card');

    cards.forEach(card => {
      const text = card.textContent.toLowerCase();

      if (text.includes(query)) {
        card.style.display = "block";
      } else {
        card.style.display = "none";
      }
    });
  });
}