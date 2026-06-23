(() => {
  const statusMap = {
    udpfs: { on: 'Running (Preferred)', off: 'Stopped' },
    udpbd: { on: 'Running (Optional)', off: 'Optional / Disabled' }
  };

  document.querySelectorAll('[data-toggle]').forEach((btn) => {
    btn.addEventListener('click', () => {
      const key = btn.getAttribute('data-toggle');
      const el = document.querySelector(`[data-status="${key}"]`);
      if (!el || !statusMap[key]) return;
      const isOn = el.classList.contains('on');
      el.classList.toggle('on', !isOn);
      el.classList.toggle('off', isOn);
      el.textContent = isOn ? statusMap[key].off : statusMap[key].on;
    });
  });

  const logBox = document.getElementById('logbox');
  const addLogBtn = document.getElementById('add-log');
  if (logBox && addLogBtn) {
    addLogBtn.addEventListener('click', () => {
      const now = new Date();
      const stamp = now.toTimeString().slice(0, 8);
      logBox.textContent += `\n[${stamp}] mock: user triggered log update`;
    });
  }
})();
