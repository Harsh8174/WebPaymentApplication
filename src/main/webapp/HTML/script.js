/**
 * 
 */
/**
 * 
 */
/**

 * 
 */
/**
 

* 
 */

  // ── Wait for DOM to load ──
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

  // ── Page switch ──
  function showPage(id) {

      document.querySelectorAll('.page').forEach(p => {
          p.classList.remove('active');
      });

      const page = document.getElementById(id);

      if(page){
          page.classList.add('active');
      }

      window.scrollTo(0, 0);
  }
  // ── UPI Preview ──
  function updateUpiPreview() {
      const input = document.getElementById('upi-handle');

      // Remove everything except digits
      input.value = input.value.replace(/\D/g, '');

      const h = input.value;
      const box = document.getElementById('upi-preview-box');
      const txt = document.getElementById('upi-preview-text');

      if (h) {
          box.style.display = 'block';
          txt.textContent = h + '@payflow';
      } else {
          box.style.display = 'none';
      }
  }

  // ── Validation helpers ──
  function isBlank(id) { return !document.getElementById(id).value.trim(); }

  function shake(id) {
    const el = document.getElementById(id);
    el.classList.add('error');
    el.style.animation = 'none';
    el.offsetHeight;
    el.style.animation = 'shake 0.3s ease';
    setTimeout(() => el.classList.remove('error'), 2000);
  }

  // ── Step navigation ──
  function goStep(n) {

      for(let i = 1; i <= 3; i++) {

          const step = document.getElementById('step-' + i);
          const prog = document.getElementById('prog-' + i);

          if(step){
              step.classList.remove('visible');
          }

          if(prog){
              prog.classList.remove('active', 'done');
          }
      }

      const currentStep = document.getElementById('step-' + n);
      const currentProg = document.getElementById('prog-' + n);

      if(currentStep){
          currentStep.classList.add('visible');
      }

      if(currentProg){
          currentProg.classList.add('active');
      }

      for(let i = 1; i < n; i++) {

          const prog = document.getElementById('prog-' + i);

          if(prog){
              prog.classList.remove('active');
              prog.classList.add('done');

              const dot = prog.querySelector('.prog-dot');

              if(dot){
                  dot.textContent = '✓';
              }
          }
      }
  }

  function goStep2() {
    const fields = ['full-name', 'bank-name', 'acc-num', 'acc-num-c', 'ifsc', 'acc-type', 'mobile'];
    let valid = true;

    fields.forEach(f => {
      if (isBlank(f)) { shake(f); valid = false; }
    });

    if (!valid) return;

    const acc = document.getElementById('acc-num').value.trim();
    const accC = document.getElementById('acc-num-c').value.trim();
    if (acc !== accC) {
      shake('acc-num-c');
      alert('Account numbers do not match.');
      return;
    }

    goStep(2);
  }

  function goStep3() {
    const upiHandle = document.getElementById('upi-handle').value.trim();
    const txnLimit = document.getElementById('txn-limit').value;

    if (!upiHandle) { shake('upi-handle'); return; }
    if (!txnLimit) { shake('txn-limit'); return; }
      
    goStep(3);
  }

  // ── PIN inputs ──
  function setupPinRow(prefix, count = 6) {
    for (let i = 0; i < count; i++) {
      const el = document.getElementById(prefix + i);
      if (!el) continue; // Skip if element doesn't exist
      el.addEventListener('input', (e) => {
        const v = e.target.value.replace(/\D/g, '');
        e.target.value = v ? v[0] : '';
        if (v && i < count - 1) {
          const nextEl = document.getElementById(prefix + (i + 1));
          if (nextEl) nextEl.focus();
        }
      });
      el.addEventListener('keydown', (e) => {
        if (e.key === 'Backspace' && !e.target.value && i > 0) {
          const prevEl = document.getElementById(prefix + (i - 1));
          if (prevEl) prevEl.focus();
        }
      });
    }
  }

  setupPinRow('p', 6);
  setupPinRow('cp', 6);

  function getPin(prefix, count = 6) {
    return Array.from({ length: count }, (_, i) => {
      const el = document.getElementById(prefix + i);
      return el ? el.value : '';
    }).join('');
  }

  // ── Create UPI ──
  function createUPI() {
    const pin = getPin('p');
    const pinC = getPin('cp');
    const last6 = document.getElementById('card-last6').value.trim();
    const expiry = document.getElementById('card-expiry').value.trim();

    if (pin.length < 6) { alert('Please enter all 6 digits of your UPI PIN.'); return; }
    if (pin !== pinC) { alert('PINs do not match. Please try again.'); return; }
    if (last6.length < 6) { shake('card-last6'); return; }
    if (!expiry) { shake('card-expiry'); return; }

    // Fill success data
    const upiId = document.getElementById('upi-handle').value.trim() + '@payflow';
    const bank = document.getElementById('bank-name').value;
    const name = document.getElementById('full-name').value.trim();
    const limit = document.getElementById('txn-limit').value;

    const successUpiId = document.getElementById('success-upi-id');
    const successBank = document.getElementById('success-bank');
    const successName = document.getElementById('success-name');
    const successLimit = document.getElementById('success-limit');
    
    if (successUpiId) successUpiId.textContent = upiId;
    if (successBank) successBank.textContent = bank;
    if (successName) successName.textContent = name;
    if (successLimit) successLimit.textContent = limit;

    // Animate btn
    const btn = document.getElementById('create-btn');
    if (btn) {
      btn.disabled = true;
      btn.textContent = 'Creating...';
    }

    setTimeout(() => {
      showPage('page-success');
      launchConfetti();
    }, 1200);
  }

  // ── Confetti ──
  function launchConfetti() {
    const container = document.getElementById('confetti');
    if (!container) return; // Skip if container doesn't exist
    
    const colors = ['#00e5a0', '#0066ff', '#ffffff', '#ffcc00', '#ff5572', '#b87cff'];
    for (let i = 0; i < 80; i++) {
      const piece = document.createElement('div');
      piece.className = 'confetti-piece';
      piece.style.left = Math.random() * 100 + 'vw';
      piece.style.background = colors[Math.floor(Math.random() * colors.length)];
      piece.style.width = (Math.random() * 8 + 6) + 'px';
      piece.style.height = (Math.random() * 8 + 6) + 'px';
      piece.style.borderRadius = Math.random() > 0.5 ? '50%' : '2px';
      piece.style.animationDuration = (Math.random() * 2 + 2) + 's';
      piece.style.animationDelay = (Math.random() * 0.8) + 's';
      container.appendChild(piece);
      setTimeout(() => piece.remove(), 4000);
    }
  }

  // ── IFSC uppercase ──
  const ifscInput = document.getElementById('ifsc');
  if (ifscInput) {
    ifscInput.addEventListener('input', function() {
      this.value = this.value.toUpperCase();
    });
  }

  // ── Card expiry format ──
  const cardExpiryInput = document.getElementById('card-expiry');
  if (cardExpiryInput) {
    cardExpiryInput.addEventListener('input', function(e) {
      let v = e.target.value.replace(/\D/g, '');
      if (v.length >= 3) v = v.slice(0, 2) + '/' + v.slice(2, 4);
      e.target.value = v;
    });
  }
  
  
  window.onload = function() {

      // Welcome page only
      if (typeof bankVerified === "undefined") {
          return;
      }

      // UPI pages
      if (typeof upiCreated !== "undefined" && upiCreated) {
          showPage('page-pin');
          goStep(3);
          return;
      }

      if (bankVerified) {
          showPage('page-upi');
          goStep(2);
      } else {
          showPage('page-bank');
          goStep(1);
      }
  };
  
  function validateBankForm() {
	alert("validateBankForm called");
	
      const fullName = document.getElementById('full-name').value.trim();
      const bankName = document.getElementById('bank-name').value;
      const accNum = document.getElementById('acc-num').value.trim();
      const accNumC = document.getElementById('acc-num-c').value.trim();
      const ifsc = document.getElementById('ifsc').value.trim();
      const accType = document.getElementById('acc-type').value;
      const mobile = document.getElementById('mobile').value.trim();
	  console.log("Full Name =", fullName);
	  	console.log("Length =", fullName.length);
	  if(fullName === ""){
		showToast("Enter Full Name", false);
          return false;
      }
	 if(!/^[A-Za-z ]{3,50}$/.test(fullName)){
	      showToast("Invalid User Name", false);
	      return false;
	  }
	  
      if(bankName === ""){
		showToast("Select Bank", false);
          return false;
      }

      if(accNum === ""){
		showToast("Account Numbers do not match", false);
          return false;
      }

      if(accNum !== accNumC){
		showToast("Account Numbers do not match", false);
          return false;
      }

	  if (!/^[A-Za-z]{1,5}\d{4}$/.test(ifsc.trim())) {
	      showToast("Invalid ifsc", false);
	      return false;
	  }

      if(accType === ""){
		showToast("select account type", false);
          return false;
      }

      if(!/^[0-9]{10}$/.test(mobile)){
		showToast("Enter valid 10 digit mobile number", false);
          return false;
      }

      return true;
  }
  
  function validatePinForm() {
    const pin = getPin('p');
    const confirmPin = getPin('cp');

    const last6 = document.getElementById('card-last6').value.trim();
    const expiry = document.getElementById('card-expiry').value.trim();

    if (pin.length !== 6) {
      showToast("Enter 6 digit PIN", false);
      return false;
    }

    if (pin !== confirmPin) {
      showToast("PINs do not match", false);
      return false;
    }

    if (!/^[0-9]{6}$/.test(last6)) {
      showToast("Enter last 6 digits of card", false);
      return false;
    }

    if (!/^(0[1-9]|1[0-2])\/[0-9]{2}$/.test(expiry)) {
      showToast("Enter expiry in MM/YY format", false);
      return false;
    }

    return true;
  }
  
  function showToast(message, isSuccess) {
      const oldToast = document.getElementById("toastMsg");
      if (oldToast) {
          oldToast.remove();
      }

      const toast = document.createElement("div");

      toast.id = "toastMsg";
      toast.className = "toast-msg " + (isSuccess ? "toast-success" : "toast-error");

      toast.innerHTML = `
          <span>${isSuccess ? "✓" : "✕"}</span>
          <span>${message}</span>
          <button class="toast-close"
                  onclick="document.getElementById('toastMsg').remove()">
              &times;
          </button>
      `;

      document.body.appendChild(toast);

      setTimeout(() => {
          const t = document.getElementById("toastMsg");
          if (t) {
              t.remove();
          }
      }, 4000);
  }
  
  
  function showToast1(message, isSuccess) {
    const oldToast = document.getElementById("toastMsg");
    if (oldToast) {
      oldToast.remove();
    }

    const toast = document.createElement("div");
    toast.id = "toastMsg";
    toast.className = "toast-msg " + (isSuccess ? "toast-success" : "toast-error");

    toast.innerHTML = `
      <span>${isSuccess ? "✓" : "✕"}</span>
      <span>${message}</span>
      <button class="toast-close"
              onclick="document.getElementById('toastMsg').remove()">
        &times;
      </button>
    `;

    document.body.appendChild(toast);

    setTimeout(() => {
      const t = document.getElementById("toastMsg");
      if (t) {
        t.remove();
      }
    }, 4000);
  }