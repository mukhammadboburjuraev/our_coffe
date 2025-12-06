(function(){
  const root = document.documentElement;
  const btn  = document.getElementById('themeToggle');
  const icon = document.getElementById('themeIcon');

  // initial
  const saved = localStorage.getItem('theme');
  if(saved === 'dark'){ root.setAttribute('data-theme','dark'); icon.textContent = '☀️'; }
  else { root.setAttribute('data-theme','light'); icon.textContent = '🌙'; }

  // toggle
  if(btn){
    btn.addEventListener('click', () => {
      const next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
      root.setAttribute('data-theme', next);
      localStorage.setItem('theme', next);
      icon.textContent = next === 'dark' ? '☀️' : '🌙';
    });
  }

  // (opsiyonel) sepette ürün sayısını badge’e yaz
  const badge = document.querySelector('.fab__badge');
  if (badge){
    // JSP ile .fab__badge içine server-side sayı basacağız; burası sadece görsel anim için.
  }
})();
