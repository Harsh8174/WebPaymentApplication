<%@page import="Model.User_Bankdetails"%>
<%@page import="Model.User"%>
<%@page import="Model.User_Upi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
User_Upi u1 = (User_Upi)session.getAttribute("User_upi");
User u = (User)session.getAttribute("User");
User_Bankdetails u_bank=(User_Bankdetails)session.getAttribute("user_bank");
System.out.print(u_bank.getBankbalance());
Boolean profileimage=(Boolean)session.getAttribute("profileimage");
String imagename=(String)session.getAttribute("image_name");
char first_letter=u.getUsername().charAt(0);
String full_name=u.getUsername();
String upi_id=u1.getUpi_id();
System.out.println(imagename);
    if (full_name == null) response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Payflow &mdash; Receive</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --bg: #080c14; --border: rgba(255,255,255,0.07);
      --accent: #00e5a0; --accent2: #0066ff; --text: #f0f4ff; --muted: #7a8599;
      --card: rgba(255,255,255,0.04); --red: #ff5572; --orange: #ff9632;
    }
    body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); min-height: 100vh; display: flex; overflow-x: hidden; }
    body::before { content: ''; position: fixed; inset: 0; background: radial-gradient(ellipse 60% 40% at 80% 0%, rgba(0,102,255,0.12) 0%, transparent 55%), radial-gradient(ellipse 40% 30% at 5% 90%, rgba(0,229,160,0.08) 0%, transparent 50%); pointer-events: none; z-index: 0; }

    .sidebar form { display: block; width: 100%; }
    .sidebar form button.nav-item { width: 100%; background: none; border: none; text-align: left; font-family: 'DM Sans', sans-serif; cursor: pointer; color: inherit; padding: 0; }
    .sidebar-logo-btn { display: flex; align-items: center; gap: 10px; background: none; border: none; cursor: pointer; padding: 0; width: 100%; }
    .sidebar { position: fixed; top: 0; left: 0; width: 240px; height: 100vh; background: rgba(8,12,20,0.90); backdrop-filter: blur(20px); border-right: 1px solid var(--border); display: flex; flex-direction: column; padding: 28px 0; z-index: 50; }
    .sidebar-logo { display: flex; align-items: center; gap: 10px; padding: 0 24px 32px; border-bottom: 1px solid var(--border); margin-bottom: 20px; }
    .sidebar-logo .logo-mark { width: 34px; height: 34px; background: linear-gradient(135deg, var(--accent2), var(--accent)); border-radius: 10px; display: grid; place-items: center; font-size: 0.9rem; flex-shrink: 0; }
    .sidebar-logo span { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.1rem; color: var(--text); }
    .nav-group-label { font-size: 0.68rem; font-weight: 600; letter-spacing: 1.8px; text-transform: uppercase; color: var(--muted); padding: 0 24px; margin: 16px 0 8px; }
    .nav-item { display: flex; align-items: center; gap: 12px; padding: 11px 24px; font-size: 0.9rem; font-weight: 500; color: var(--muted); cursor: pointer; transition: all 0.2s ease; border-left: 3px solid transparent; margin: 1px 0; }
    .nav-item:hover { color: var(--text); background: rgba(255,255,255,0.04); }
    .nav-item.active { color: var(--accent2); background: rgba(0,102,255,0.08); border-left-color: var(--accent2); }
    .nav-item .nav-icon { width: 20px; text-align: center; font-size: 1rem; flex-shrink: 0; }
    .nav-badge { margin-left: auto; background: var(--red); color: #fff; font-size: 0.65rem; font-weight: 700; padding: 2px 7px; border-radius: 100px; }
    .sidebar-bottom { margin-top: auto; padding: 20px 24px 0; border-top: 1px solid var(--border); }
    .sidebar-user { display: flex; align-items: center; gap: 12px; padding: 12px 0; }
    .sidebar-avatar { width: 38px; height: 38px; border-radius: 50%; background: linear-gradient(135deg, var(--accent2), var(--accent)); display: grid; place-items: center; font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.95rem; color: #fff; flex-shrink: 0; overflow: hidden; }
    .sidebar-avatar img { width: 100%; height: 100%; object-fit: cover; }
    .sidebar-user-info .s-name { font-size: 0.88rem; font-weight: 600; color: var(--text); }
    .sidebar-user-info .s-email { font-size: 0.74rem; color: var(--muted); }

    .main { margin-left: 240px; flex: 1; position: relative; z-index: 1; padding: 36px 40px 60px; min-height: 100vh; }
    .topbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 36px; }
    .topbar-left h1 { font-family: 'Syne', sans-serif; font-size: 1.7rem; font-weight: 800; letter-spacing: -0.5px; }
    .topbar-left p { font-size: 0.88rem; color: var(--muted); margin-top: 3px; }

    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
    .dash-card { background: var(--card); border: 1px solid var(--border); border-radius: 20px; padding: 28px; }
    .card-title { font-family: 'Syne', sans-serif; font-size: 1rem; font-weight: 700; margin-bottom: 22px; display: block; }

    /* QR BOX */
    .qr-box { display: flex; flex-direction: column; align-items: center; gap: 20px; padding: 10px 0; }
    .qr-frame { width: 200px; height: 200px; background: #fff; border-radius: 16px; display: grid; place-items: center; padding: 12px; }
    .qr-frame svg { width: 100%; height: 100%; }
    .upi-pill { display: inline-flex; align-items: center; gap: 8px; background: rgba(0,229,160,0.1); border: 1px solid rgba(0,229,160,0.25); border-radius: 100px; padding: 8px 18px; font-size: 0.88rem; font-weight: 600; color: var(--accent); }
    .btn-outline { display: inline-flex; align-items: center; gap: 8px; background: rgba(255,255,255,0.05); border: 1px solid var(--border); border-radius: 10px; padding: 10px 20px; font-family: 'DM Sans', sans-serif; font-size: 0.85rem; font-weight: 600; color: var(--text); cursor: pointer; transition: all 0.2s ease; }
    .btn-outline:hover { background: rgba(0,102,255,0.1); border-color: rgba(0,102,255,0.3); color: var(--accent2); }
    .btn-row { display: flex; gap: 10px; flex-wrap: wrap; justify-content: center; }

    /* REQUEST FORM */
    .form-group { margin-bottom: 18px; }
    .form-label { font-size: 0.8rem; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; display: block; }
    .form-input { width: 100%; background: rgba(255,255,255,0.05); border: 1px solid var(--border); border-radius: 12px; padding: 13px 16px; font-family: 'DM Sans', sans-serif; font-size: 0.95rem; color: var(--text); outline: none; transition: all 0.25s ease; }
    .form-input:focus { border-color: var(--accent2); background: rgba(0,102,255,0.06); box-shadow: 0 0 0 3px rgba(0,102,255,0.12); }
    .form-input::placeholder { color: rgba(122,133,153,0.5); }
    .amount-wrap { position: relative; }
    .amount-prefix { position: absolute; left: 14px; top: 50%; transform: translateY(-50%); font-family: 'Syne', sans-serif; font-weight: 700; font-size: 1.1rem; color: var(--muted); }
    .amount-input { padding-left: 34px; font-family: 'Syne', sans-serif; font-size: 1.3rem; font-weight: 800; }
    .btn-primary { width: 100%; background: linear-gradient(135deg, var(--accent2), #3385ff); color: #fff; border: none; border-radius: 12px; padding: 15px; font-family: 'DM Sans', sans-serif; font-size: 0.95rem; font-weight: 600; cursor: pointer; box-shadow: 0 0 24px rgba(0,102,255,0.3); transition: all 0.25s ease; margin-top: 8px; }
    .btn-primary:hover { transform: translateY(-1px); box-shadow: 0 4px 32px rgba(0,102,255,0.45); }

    @keyframes fadeUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }
    .anim-1 { animation: fadeUp 0.5s 0.05s ease both; }
    .anim-2 { animation: fadeUp 0.5s 0.12s ease both; }
    @media (max-width: 1000px) { .two-col { grid-template-columns: 1fr; } }
    @media (max-width: 900px) { .sidebar { display: none; } .main { margin-left: 0; padding: 24px 20px 50px; } }
  </style>
</head>
<body>
  <aside class="sidebar">
    <form method="post" action="index.jsp" class="sidebar-logo">
      <button type="submit" class="sidebar-logo-btn"><span class="logo-mark">&#x26A1;</span><span>PBM PAYFLOW</span></button>
    </form>
    <div class="nav-group-label">Main</div>
    <form method="post" action="dashboard.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F3E0;</span> Dashboard</button></form>
    <form method="post" action="transactions.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x21C4;</span> Transactions<span class="nav-badge">3</span></button></form>
    <form method="post" action="sendMoney.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F4B8;</span> Send Money</button></form>
    <form method="post" action="receive.jsp"><button type="submit" class="nav-item active"><span class="nav-icon">&#x1F4E5;</span> Receive</button></form>
    <form method="post" action="upiQr.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F4F1;</span> UPI &amp; QR</button></form>
    <div class="nav-group-label">Finance</div>
    <form method="post" action="analytics.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F4CA;</span> Analytics</button></form>
    <form method="post" action="bankAccounts.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F3E6;</span> Bank Accounts</button></form>
    <form method="post" action="cards.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F4B3;</span> Cards</button></form>
    <div class="nav-group-label">Account</div>
    <form method="post" action="settings.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x2699;</span> Settings</button></form>
    <form method="post" action="./userregister"><button type="submit" class="nav-item" name="submit" value="Logout"><span class="nav-icon">&#x1F6AA;</span> Logout</button></form>
    <div class="sidebar-bottom">
      <div class="sidebar-user">
        <div class="sidebar-avatar">
           <% if (imagename != null && !imagename.isEmpty()) { %><img src= "images/<%= imagename %>" alt="Profile"/>
          <% } else { %> <%= first_letter %><% } %>
        </div>
        <div class="sidebar-user-info">
          <div class="s-name"><%= full_name %></div>
          <div class="s-email"><%= upi_id %></div>
        </div>
      </div>
    </div>
  </aside>

  <main class="main">
    <div class="topbar anim-1">
      <div class="topbar-left">
        <h1>Receive Money &#x2198;</h1>
        <p>Share your QR or UPI ID to receive payments instantly.</p>
      </div>
    </div>

    <div class="two-col">

      
      <!-- Request Money -->
      <div class="dash-card anim-2">
        <span class="card-title">Request Money</span>
        <form method="post" action="./requestMoneyController">
          <div class="form-group">
            <label class="form-label">Request From (UPI ID / Mobile)</label>
            <input type="text" name="fromUpi" class="form-input" placeholder="e.g. friend@upi or 9876543210" required />
          </div>
          <div class="form-group">
            <label class="form-label">Amount</label>
            <div class="amount-wrap">
              <span class="amount-prefix">&#x20B9;</span>
              <input type="number" name="amount" class="form-input amount-input" placeholder="0" min="1" required />
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Note (Optional)</label>
            <input type="text" name="note" class="form-input" placeholder="e.g. For dinner last night" />
          </div>
          <button type="submit" class="btn-primary">&#x1F4E8; Send Request</button>
        </form>
      </div>

    </div>
  </main>
</body>
</html>
