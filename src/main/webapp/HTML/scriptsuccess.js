// mainscript.js — PBM Payflow UPI Setup
document.addEventListener('DOMContentLoaded', function() {
    // Only run if userName exists and is not empty
    if (typeof userName !== 'undefined' && userName) {
      const userInitial = userName.charAt(0).toUpperCase();
      const navAvatar = document.getElementById('nav-avatar');
      const navName = document.getElementById('nav-name');
      const welcomeName = document.getElementById('welcome-name');
      
      if (navAvatar) navAvatar.textContent = userInitial;
      if (navName) navName.textContent = userName.split(' ')[0];
      if (welcomeName) welcomeName.textContent = userName.split(' ')[0];
    }
  });
// ── Wait for DOM ──
document.addEventListener('DOMContentLoaded', function () {

  // Setup PIN rows if inputs exist on this page
  setupPinRow('p',  6);
  setupPinRow('cp', 6);

  // IFSC uppercase
  const ifscInput = document.getElementById('ifsc');
  if (ifscInput) {
    ifscInput.addEventListener('input', function () {
      this.value = this.value.toUpperCase();
    });
  }

  // Card expiry MM/YY auto-format
  const cardExpiryInput = document.getElementById('card-expiry');
  if (cardExpiryInput) {
    cardExpiryInput.addEventListener('input', function (e) {
      let v = e.target.value.replace(/\D/g, '');
      if (v.length >= 3) v = v.slice(0, 2) + '/' + v.slice(2, 4);
      e.target.value = v;
    });
  }
});

// ── window.onload — decide which page/step to show ──
window.onload = function () {

  // If JSP set showSuccess = true, go straight to success
  if (typeof showSuccess !== 'undefined' && showSuccess) {
    showPage('page-success');
    launchConfetti();
    return;
  }

  // Welcome page — no bankVerified flag means first load
  if (typeof bankVerified === 'undefined') {
    showPage('page-welcome');
    return;
  }

  // UPI pages
  if (typeof upiCreated !== 'undefined' && upiCreated) {
    showPage('page-form');
    goStep(3);
    return;
  }

  if (bankVerified) {
    showPage('page-form');
    goStep(2);
  } else {
    showPage('page-form');
    goStep(1);
  }
};

// ── Page switch ──
function showPage(id) {
  document.querySelectorAll('.page').forEach(function (p) {
    p.classList.remove('active');
  });
  const page = document.getElementById(id);
  if (page) page.classList.add('active');
  window.scrollTo(0, 0);
}

// ── UPI Handle Preview ──
function updateUpiPreview() {
  const input = document.getElementById('upi-handle');
  if (!input) return;

  // Allow letters, numbers, dots only
  input.value = input.value.replace(/[^a-zA-Z0-9.]/g, '');

  const h   = input.value;
  const box = document.getElementById('upi-preview-box');
  const txt = document.getElementById('upi-preview-text');

  if (h && box && txt) {
    box.style.display = 'block';
    txt.textContent   = h + '@payflow';
  } else if (box) {
    box.style.display = 'none';
  }
}

// ── Validation helpers ──
function isBlank(id) {
  const el = document.getElementById(id);
  return !el || !el.value.trim();
}

function shake(id) {
  const el = document.getElementById(id);
  if (!el) return;
  el.classList.add('error');
  el.style.animation = 'none';
  el.offsetHeight; // reflow
  el.style.animation = 'shake 0.3s ease';
  setTimeout(function () { el.classList.remove('error'); }, 2000);
}

// ── Step navigation ──
function goStep(n) {
  for (let i = 1; i <= 3; i++) {
    const step = document.getElementById('step-' + i);
    const prog = document.getElementById('prog-' + i);
    if (step) step.classList.remove('visible');
    if (prog) prog.classList.remove('active', 'done');
  }

  const currentStep = document.getElementById('step-' + n);
  const currentProg = document.getElementById('prog-' + n);
  if (currentStep) currentStep.classList.add('visible');
  if (currentProg) currentProg.classList.add('active');

  for (let i = 1; i < n; i++) {
    const prog = document.getElementById('prog-' + i);
    if (prog) {
      prog.classList.remove('active');
      prog.classList.add('done');
      const dot = prog.querySelector('.prog-dot');
      if (dot) dot.textContent = '\u2713'; // ✓ as unicode escape
    }
  }
}

// ── Step 1: Bank Details validation ──
function goStep2() {
  const fields = ['full-name', 'bank-name', 'acc-num', 'acc-num-c', 'ifsc', 'acc-type', 'mobile'];
  let valid = true;

  fields.forEach(function (f) {
    if (isBlank(f)) { shake(f); valid = false; }
  });

  if (!valid) return;

  const acc  = document.getElementById('acc-num').value.trim();
  const accC = document.getElementById('acc-num-c').value.trim();
  if (acc !== accC) {
    shake('acc-num-c');
    showToast('Account numbers do not match.', false);
    return;
  }

  goStep(2);
}

// ── Step 2: UPI Setup validation ──
function goStep3() {
  const upiHandle = document.getElementById('upi-handle');
  const txnLimit  = document.getElementById('txn-limit');

  if (!upiHandle || !upiHandle.value.trim()) {
    if (upiHandle) shake('upi-handle');
    showToast('Please enter a UPI handle.', false);
    return;
  }
  if (!txnLimit || !txnLimit.value) {
    if (txnLimit) shake('txn-limit');
    showToast('Please choose a daily transaction limit.', false);
    return;
  }

  goStep(3);
}

// ── PIN inputs auto-focus ──
function setupPinRow(prefix, count) {
  count = count || 6;
  for (let i = 0; i < count; i++) {
    (function (idx) {
      const el = document.getElementById(prefix + idx);
      if (!el) return;

      el.addEventListener('input', function (e) {
        const v = e.target.value.replace(/\D/g, '');
        e.target.value = v ? v[0] : '';
        if (v && idx < count - 1) {
          const next = document.getElementById(prefix + (idx + 1));
          if (next) next.focus();
        }
      });

      el.addEventListener('keydown', function (e) {
        if (e.key === 'Backspace' && !e.target.value && idx > 0) {
          const prev = document.getElementById(prefix + (idx - 1));
          if (prev) prev.focus();
        }
      });
    })(i);
  }
}

function getPin(prefix, count) {
  count = count || 6;
  return Array.from({ length: count }, function (_, i) {
    const el = document.getElementById(prefix + i);
    return el ? el.value : '';
  }).join('');
}

// ── Bank Form validate (used by JSP form onsubmit) ──
function validateBankForm() {
  const fullName = document.getElementById('full-name').value.trim();
  const bankName = document.getElementById('bank-name').value;
  const accNum   = document.getElementById('acc-num').value.trim();
  const accNumC  = document.getElementById('acc-num-c').value.trim();
  const ifsc     = document.getElementById('ifsc').value.trim();
  const accType  = document.getElementById('acc-type').value;
  const mobile   = document.getElementById('mobile').value.trim();

  if (fullName === '') {
    showToast('Enter Full Name.', false); return false;
  }
  if (!/^[A-Za-z ]{3,50}$/.test(fullName)) {
    showToast('Invalid Full Name.', false); return false;
  }
  if (bankName === '') {
    showToast('Select a Bank.', false); return false;
  }
  if (accNum === '') {
    showToast('Enter Account Number.', false); return false;
  }
  if (accNum !== accNumC) {
    showToast('Account numbers do not match.', false); return false;
  }
  if (!/^[A-Za-z]{4}[A-Z0-9]{7}$/.test(ifsc)) {
    showToast('Invalid IFSC Code (e.g. SBIN0001234).', false); return false;
  }
  if (accType === '') {
    showToast('Select Account Type.', false); return false;
  }
  if (!/^[0-9]{10}$/.test(mobile)) {
    showToast('Enter a valid 10-digit mobile number.', false); return false;
  }
  return true;
}

// ── PIN Form validate (used by JSP form onsubmit) ──
function validatePinForm() {
  const pin        = getPin('p');
  const confirmPin = getPin('cp');
  const last6      = document.getElementById('card-last6').value.trim();
  const expiry     = document.getElementById('card-expiry').value.trim();

  if (pin.length !== 6) {
    showToast('Enter a 6-digit PIN.', false); return false;
  }
  if (pin !== confirmPin) {
    showToast('PINs do not match.', false); return false;
  }
  if (!/^[0-9]{6}$/.test(last6)) {
    showToast('Enter the last 6 digits of your debit card.', false); return false;
  }
  if (!/^(0[1-9]|1[0-2])\/[0-9]{2}$/.test(expiry)) {
    showToast('Enter card expiry in MM/YY format.', false); return false;
  }
  return true;
}

// ── Create UPI (pure front-end flow, no JSP) ──
function createUPI() {
  if (!validatePinForm()) return;

  const upiId = document.getElementById('upi-handle').value.trim() + '@payflow';
  const bank  = document.getElementById('bank-name').value;
  const name  = document.getElementById('full-name').value.trim();
  const limit = document.getElementById('txn-limit').value;

  const el_id    = document.getElementById('success-upi-id');
  const el_bank  = document.getElementById('success-bank');
  const el_name  = document.getElementById('success-name');
  const el_limit = document.getElementById('success-limit');

  if (el_id)    el_id.textContent    = upiId;
  if (el_bank)  el_bank.textContent  = bank;
  if (el_name)  el_name.textContent  = name;
  if (el_limit) el_limit.textContent = '\u20B9' + limit; // ₹

  const btn = document.getElementById('create-btn');
  if (btn) { btn.disabled = true; btn.textContent = 'Creating\u2026'; }

  setTimeout(function () {
    showPage('page-success');
    launchConfetti();
  }, 1200);
}

// ── Confetti ──
function launchConfetti() {
  const container = document.getElementById('confetti');
  if (!container) return;

  const colors = ['#00e5a0', '#0066ff', '#ffffff', '#ffcc00', '#ff5572', '#b87cff'];

  for (let i = 0; i < 80; i++) {
    const piece = document.createElement('div');
    piece.className = 'confetti-piece';
    piece.style.left              = (Math.random() * 100) + 'vw';
    piece.style.background        = colors[Math.floor(Math.random() * colors.length)];
    piece.style.width             = (Math.random() * 8 + 6) + 'px';
    piece.style.height            = (Math.random() * 8 + 6) + 'px';
    piece.style.borderRadius      = Math.random() > 0.5 ? '50%' : '2px';
    piece.style.animationDuration = (Math.random() * 2 + 2) + 's';
    piece.style.animationDelay    = (Math.random() * 0.8) + 's';
    container.appendChild(piece);
    setTimeout(function () { piece.remove(); }, 4000);
  }
}

// ── Toast notification ──
function showToast(message, isSuccess) {
  const oldToast = document.getElementById('toastMsg');
  if (oldToast) oldToast.remove();

  const toast      = document.createElement('div');
  toast.id         = 'toastMsg';
  toast.className  = 'toast-msg ' + (isSuccess ? 'toast-success' : 'toast-error');

  // Use unicode escapes — no raw emoji or symbols
  const icon = isSuccess ? '\u2713' : '\u2715'; // ✓ or ✕

  toast.innerHTML =
    '<span>' + icon + '</span>' +
    '<span>' + message + '</span>' +
    '<button class="toast-close" onclick="document.getElementById(\'toastMsg\').remove()">' +
    '&times;</button>';

  document.body.appendChild(toast);

  setTimeout(function () {
    const t = document.getElementById('toastMsg');
    if (t) t.remove();
  }, 4000);
}

// Alias — kept for backward compatibility with older JSP calls
var showToast1 = showToast;