<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Payflow — Move Money Freely</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet"/>
 
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

    :root {
      --bg: #080c14;
      --surface: #0f1623;
      --border: rgba(255,255,255,0.07);
      --accent: #00e5a0;
      --accent2: #0066ff;
      --text: #f0f4ff;
      --muted: #7a8599;
      --card: rgba(255,255,255,0.04);
    }

    html { scroll-behavior: smooth; }

    body {
      font-family: 'DM Sans', sans-serif;
      background: var(--bg);
      color: var(--text);
      overflow-x: hidden;
      min-height: 100vh;
    }

    /* ── Background ── */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background:
        radial-gradient(ellipse 80% 60% at 60% -10%, rgba(0,102,255,0.18) 0%, transparent 60%),
        radial-gradient(ellipse 50% 40% at 10% 80%, rgba(0,229,160,0.12) 0%, transparent 55%);
      pointer-events: none;
      z-index: 0;
    }

    /* ── NAV ── */
    nav {
      position: fixed;
      top: 0; left: 0; right: 0;
      z-index: 100;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 5%;
      height: 72px;
      background: rgba(8,12,20,0.75);
      backdrop-filter: blur(18px);
      border-bottom: 1px solid var(--border);
    }

    .nav-logo {
      font-family: 'Syne', sans-serif;
      font-weight: 800;
      font-size: 1.45rem;
      letter-spacing: -0.5px;
      color: var(--text);
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .nav-logo .logo-mark {
      width: 34px; height: 34px;
      background: linear-gradient(135deg, var(--accent2), var(--accent));
      border-radius: 10px;
      display: grid;
      place-items: center;
      font-size: 0.95rem;
    }

    .nav-actions { display: flex; gap: 12px; align-items: center; }

    .btn {
      font-family: 'DM Sans', sans-serif;
      font-size: 0.875rem;
      font-weight: 500;
      padding: 9px 22px;
      border-radius: 10px;
      cursor: pointer;
      text-decoration: none;
      transition: all 0.25s ease;
      border: none;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    .btn-ghost {
      background: transparent;
      color: var(--muted);
      border: 1px solid var(--border);
    }
    .btn-ghost:hover {
      color: var(--text);
      border-color: rgba(255,255,255,0.2);
      background: rgba(255,255,255,0.05);
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--accent2), #3385ff);
      color: #fff;
      box-shadow: 0 0 24px rgba(0,102,255,0.35);
    }
    .btn-primary:hover {
      transform: translateY(-1px);
      box-shadow: 0 4px 32px rgba(0,102,255,0.5);
    }

    .btn-accent {
      background: linear-gradient(135deg, var(--accent), #00c47a);
      color: #080c14;
      font-weight: 700;
      box-shadow: 0 0 28px rgba(0,229,160,0.3);
    }
    .btn-accent:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 36px rgba(0,229,160,0.45);
    }

    .btn-outline {
      background: transparent;
      color: var(--text);
      border: 1px solid rgba(255,255,255,0.18);
    }
    .btn-outline:hover {
      background: rgba(255,255,255,0.06);
      border-color: rgba(255,255,255,0.35);
    }

    /* ── HERO ── */
    .hero {
      position: relative;
      z-index: 1;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      padding: 100px 5% 60px;
    }

    .hero-badge {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: rgba(0,229,160,0.1);
      border: 1px solid rgba(0,229,160,0.25);
      border-radius: 100px;
      padding: 6px 16px;
      font-size: 0.78rem;
      font-weight: 500;
      color: var(--accent);
      letter-spacing: 0.5px;
      margin-bottom: 32px;
      animation: fadeUp 0.6s ease both;
    }

    .hero-badge .dot {
      width: 7px; height: 7px;
      background: var(--accent);
      border-radius: 50%;
      animation: pulse 2s infinite;
    }

    @keyframes pulse {
      0%,100% { opacity: 1; transform: scale(1); }
      50% { opacity: 0.5; transform: scale(1.4); }
    }

    .hero h1 {
      font-family: 'Syne', sans-serif;
      font-size: clamp(2.8rem, 7vw, 5.5rem);
      font-weight: 800;
      line-height: 1.05;
      letter-spacing: -2px;
      max-width: 820px;
      margin-bottom: 24px;
      animation: fadeUp 0.7s 0.1s ease both;
    }

    .hero h1 .highlight {
      background: linear-gradient(90deg, var(--accent2), var(--accent));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .hero p {
      font-size: clamp(1rem, 2vw, 1.2rem);
      color: var(--muted);
      max-width: 540px;
      line-height: 1.7;
      margin-bottom: 40px;
      font-weight: 300;
      animation: fadeUp 0.7s 0.2s ease both;
    }

    .hero-cta {
      display: flex;
      gap: 14px;
      flex-wrap: wrap;
      justify-content: center;
      animation: fadeUp 0.7s 0.3s ease both;
    }

    .btn-lg { padding: 14px 32px; font-size: 1rem; border-radius: 13px; }

    /* ── STATS STRIP ── */
    .stats {
      position: relative;
      z-index: 1;
      display: flex;
      justify-content: center;
      gap: 0;
      flex-wrap: wrap;
      margin: 60px auto 0;
      max-width: 860px;
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 20px;
      overflow: hidden;
      animation: fadeUp 0.7s 0.4s ease both;
    }

    .stat-item {
      flex: 1;
      min-width: 180px;
      padding: 28px 32px;
      text-align: center;
      border-right: 1px solid var(--border);
    }
    .stat-item:last-child { border-right: none; }

    .stat-num {
      font-family: 'Syne', sans-serif;
      font-size: 2rem;
      font-weight: 800;
      color: var(--text);
      display: block;
    }

    .stat-num span { color: var(--accent); }

    .stat-label {
      font-size: 0.82rem;
      color: var(--muted);
      margin-top: 4px;
      display: block;
      letter-spacing: 0.3px;
    }

    /* ── FEATURES ── */
    .section {
      position: relative;
      z-index: 1;
      padding: 100px 5%;
      max-width: 1200px;
      margin: 0 auto;
    }

    .section-label {
      font-size: 0.78rem;
      font-weight: 600;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--accent2);
      margin-bottom: 12px;
    }

    .section-title {
      font-family: 'Syne', sans-serif;
      font-size: clamp(1.8rem, 4vw, 2.8rem);
      font-weight: 800;
      letter-spacing: -1px;
      line-height: 1.15;
      margin-bottom: 16px;
    }

    .section-sub {
      color: var(--muted);
      font-size: 1.05rem;
      font-weight: 300;
      max-width: 480px;
      line-height: 1.7;
      margin-bottom: 56px;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 20px;
    }

    .feature-card {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 20px;
      padding: 32px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .feature-card::before {
      content: '';
      position: absolute;
      inset: 0;
      background: linear-gradient(135deg, rgba(0,102,255,0.07) 0%, transparent 60%);
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .feature-card:hover { transform: translateY(-4px); border-color: rgba(255,255,255,0.14); }
    .feature-card:hover::before { opacity: 1; }

    .feature-icon {
      width: 52px; height: 52px;
      border-radius: 14px;
      display: grid;
      place-items: center;
      font-size: 1.4rem;
      margin-bottom: 20px;
      position: relative;
      z-index: 1;
    }

    .icon-blue { background: rgba(0,102,255,0.15); border: 1px solid rgba(0,102,255,0.25); }
    .icon-green { background: rgba(0,229,160,0.12); border: 1px solid rgba(0,229,160,0.25); }
    .icon-purple { background: rgba(140,80,255,0.15); border: 1px solid rgba(140,80,255,0.25); }
    .icon-orange { background: rgba(255,150,50,0.15); border: 1px solid rgba(255,150,50,0.25); }

    .feature-card h3 {
      font-family: 'Syne', sans-serif;
      font-size: 1.15rem;
      font-weight: 700;
      margin-bottom: 10px;
      position: relative; z-index: 1;
    }

    .feature-card p {
      font-size: 0.92rem;
      color: var(--muted);
      line-height: 1.65;
      position: relative; z-index: 1;
    }

    /* ── HOW IT WORKS ── */
    .steps-row {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 0;
      position: relative;
    }

    .steps-row::before {
      content: '';
      position: absolute;
      top: 30px; left: 10%;
      width: 80%;
      height: 1px;
      background: linear-gradient(90deg, transparent, var(--border), var(--border), transparent);
    }

    .step {
      text-align: center;
      padding: 0 24px 24px;
      position: relative;
    }

    .step-num {
      width: 60px; height: 60px;
      border-radius: 50%;
      background: var(--surface);
      border: 1px solid var(--border);
      display: grid;
      place-items: center;
      margin: 0 auto 20px;
      font-family: 'Syne', sans-serif;
      font-size: 1.2rem;
      font-weight: 800;
      color: var(--accent2);
      position: relative;
      z-index: 1;
    }

    .step h4 {
      font-family: 'Syne', sans-serif;
      font-weight: 700;
      font-size: 1rem;
      margin-bottom: 8px;
    }

    .step p { font-size: 0.88rem; color: var(--muted); line-height: 1.6; }

    /* ── CTA BANNER ── */
    .cta-banner {
      position: relative;
      z-index: 1;
      margin: 0 5% 100px;
      border-radius: 28px;
      background: linear-gradient(135deg, rgba(0,102,255,0.25) 0%, rgba(0,229,160,0.15) 100%);
      border: 1px solid rgba(0,102,255,0.3);
      padding: 64px 5%;
      text-align: center;
      overflow: hidden;
    }

    .cta-banner::before {
      content: '';
      position: absolute;
      inset: 0;
      background: radial-gradient(ellipse 60% 80% at 50% 50%, rgba(0,102,255,0.15), transparent);
      pointer-events: none;
    }

    .cta-banner h2 {
      font-family: 'Syne', sans-serif;
      font-size: clamp(1.8rem, 4vw, 3rem);
      font-weight: 800;
      letter-spacing: -1px;
      margin-bottom: 14px;
      position: relative; z-index: 1;
    }

    .cta-banner p {
      color: var(--muted);
      font-size: 1.05rem;
      font-weight: 300;
      margin-bottom: 36px;
      position: relative; z-index: 1;
    }

    .cta-banner .hero-cta { position: relative; z-index: 1; }

    /* ── FOOTER ── */
    footer {
      position: relative;
      z-index: 1;
      border-top: 1px solid var(--border);
      padding: 40px 5%;
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 16px;
    }

    .footer-logo {
      font-family: 'Syne', sans-serif;
      font-weight: 800;
      font-size: 1.2rem;
      color: var(--text);
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 9px;
    }

    .footer-logo .logo-mark {
      width: 28px; height: 28px;
      background: linear-gradient(135deg, var(--accent2), var(--accent));
      border-radius: 8px;
      display: grid;
      place-items: center;
      font-size: 0.8rem;
    }

    footer p { font-size: 0.82rem; color: var(--muted); }

    .footer-links { display: flex; gap: 24px; }
    .footer-links a {
      font-size: 0.82rem;
      color: var(--muted);
      text-decoration: none;
      transition: color 0.2s;
    }
    .footer-links a:hover { color: var(--text); }

    /* ── ANIMATIONS ── */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(24px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* ── RESPONSIVE ── */
    @media (max-width: 640px) {
      .stats { flex-direction: column; }
      .stat-item { border-right: none; border-bottom: 1px solid var(--border); }
      .stat-item:last-child { border-bottom: none; }
      .steps-row::before { display: none; }
      footer { flex-direction: column; text-align: center; }
    }
  </style>
</head>
<body>

<%@ include file="HTML/Index.html" %>
</body>
</html>