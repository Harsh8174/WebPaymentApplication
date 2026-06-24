<%@page import="java.util.Iterator"%>
<%@page import="Model.transaction_model"%>
<%@page import="java.util.List"%>
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
  if (full_name == null) response.sendRedirect("index.jsp");
  System.out.println(imagename);
  List<transaction_model> list=(List<transaction_model>)session.getAttribute("transaction_list");
  int total_transaction=0;
  int total_debit_amount=0;
  int total_credit_amount=0;
%>
<% if(list!=null){
	   Iterator<transaction_model> itr=list.iterator();
       
	   while(itr.hasNext()){
	       total_transaction++;
		   transaction_model tm=(transaction_model)itr.next();		     
	    if(tm.getTransaction_type().equalsIgnoreCase("debit")){     
         total_debit_amount+=tm.getTransaction_amount();
%>

<%  } else {  total_credit_amount+=tm.getTransaction_amount(); %>
<%  } } } %>
         
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Payflow &mdash; Transactions</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --bg: #080c14; --surface: #0f1623; --border: rgba(255,255,255,0.07);
      --accent: #00e5a0; --accent2: #0066ff; --text: #f0f4ff; --muted: #7a8599;
      --card: rgba(255,255,255,0.04); --red: #ff5572; --orange: #ff9632; --purple: #8c50ff;
    }
    body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); min-height: 100vh; display: flex; overflow-x: hidden; }
    body::before { content: ''; position: fixed; inset: 0; background: radial-gradient(ellipse 60% 40% at 80% 0%, rgba(0,102,255,0.12) 0%, transparent 55%), radial-gradient(ellipse 40% 30% at 5% 90%, rgba(0,229,160,0.08) 0%, transparent 50%); pointer-events: none; z-index: 0; }

    /* SIDEBAR */
    .sidebar form { display: block; width: 100%; }
    .sidebar form button.nav-item { width: 100%; background: none; border: none; text-align: left; font-family: 'DM Sans', sans-serif; cursor: pointer; color: inherit; padding: 0; }
    .sidebar-logo-btn { display: flex; align-items: center; gap: 10px; background: none; border: none; cursor: pointer; padding: 0; width: 100%; }
    .sidebar { position: fixed; top: 0; left: 0; width: 240px; height: 100vh; background: rgba(8,12,20,0.90); backdrop-filter: blur(20px); border-right: 1px solid var(--border); display: flex; flex-direction: column; padding: 28px 0; z-index: 50; }
    .sidebar-logo { display: flex; align-items: center; gap: 10px; padding: 0 24px 32px; border-bottom: 1px solid var(--border); margin-bottom: 20px; }
    .sidebar-logo .logo-mark { width: 34px; height: 34px; background: linear-gradient(135deg, var(--accent2), var(--accent)); border-radius: 10px; display: grid; place-items: center; font-size: 0.9rem; flex-shrink: 0; }
    .sidebar-logo span { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.1rem; color: var(--text); letter-spacing: -0.3px; }
    .nav-group-label { font-size: 0.68rem; font-weight: 600; letter-spacing: 1.8px; text-transform: uppercase; color: var(--muted); padding: 0 24px; margin: 16px 0 8px; }
    .nav-item { display: flex; align-items: center; gap: 12px; padding: 11px 24px; font-size: 0.9rem; font-weight: 500; color: var(--muted); text-decoration: none; cursor: pointer; transition: all 0.2s ease; border-left: 3px solid transparent; margin: 1px 0; }
    .nav-item:hover { color: var(--text); background: rgba(255,255,255,0.04); }
    .nav-item.active { color: var(--accent2); background: rgba(0,102,255,0.08); border-left-color: var(--accent2); }
    .nav-item .nav-icon { width: 20px; text-align: center; font-size: 1rem; flex-shrink: 0; }
    .nav-badge { margin-left: auto; background: var(--red); color: #fff; font-size: 0.65rem; font-weight: 700; padding: 2px 7px; border-radius: 100px; }
    .sidebar-bottom { margin-top: auto; padding: 20px 24px 0; border-top: 1px solid var(--border); }
    .sidebar-user { display: flex; align-items: center; gap: 12px; padding: 12px 0; }
    .sidebar-avatar { width: 38px; height: 38px; border-radius: 50%; background: linear-gradient(135deg, var(--accent2), var(--accent)); display: grid; place-items: center; font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.95rem; color: #fff; flex-shrink: 0; overflow: hidden; }
    .sidebar-avatar img { width: 100%; height: 100%; object-fit: cover; display: block; }
    .sidebar-user-info .s-name { font-size: 0.88rem; font-weight: 600; color: var(--text); }
    .sidebar-user-info .s-email { font-size: 0.74rem; color: var(--muted); }

    /* MAIN */
    .main { margin-left: 240px; flex: 1; position: relative; z-index: 1; padding: 36px 40px 60px; min-height: 100vh; }
    .topbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 36px; }
    .topbar-left h1 { font-family: 'Syne', sans-serif; font-size: 1.7rem; font-weight: 800; letter-spacing: -0.5px; }
    .topbar-left p { font-size: 0.88rem; color: var(--muted); margin-top: 3px; }

    /* FILTER BAR */
    .filter-bar { display: flex; align-items: center; gap: 12px; margin-bottom: 24px; flex-wrap: wrap; }
    .filter-btn { display: inline-flex; align-items: center; gap: 6px; padding: 8px 18px; border-radius: 100px; font-family: 'DM Sans', sans-serif; font-size: 0.82rem; font-weight: 600; cursor: pointer; border: 1px solid var(--border); background: var(--card); color: var(--muted); transition: all 0.2s ease; }
    .filter-btn.active, .filter-btn:hover { background: rgba(0,102,255,0.12); border-color: rgba(0,102,255,0.3); color: var(--accent2); }
    .search-box { margin-left: auto; display: flex; align-items: center; gap: 10px; background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 9px 16px; }
    .search-box input { background: none; border: none; outline: none; font-family: 'DM Sans', sans-serif; font-size: 0.88rem; color: var(--text); width: 200px; }
    .search-box input::placeholder { color: var(--muted); }

    /* TABLE CARD */
    .dash-card { background: var(--card); border: 1px solid var(--border); border-radius: 20px; padding: 28px; }
    .card-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 22px; }
    .card-title { font-family: 'Syne', sans-serif; font-size: 1rem; font-weight: 700; }
    .txn-list { display: flex; flex-direction: column; gap: 4px; }
    .txn-item { display: flex; align-items: center; gap: 14px; padding: 14px 16px; border-radius: 13px; transition: background 0.2s ease; cursor: pointer; }
    .txn-item:hover { background: rgba(255,255,255,0.04); }
    .txn-avatar { width: 44px; height: 44px; border-radius: 12px; display: grid; place-items: center; font-size: 1.2rem; flex-shrink: 0; }
    .txn-info { flex: 1; min-width: 0; }
    .txn-name { font-size: 0.9rem; font-weight: 500; color: var(--text); }
    .txn-date { font-size: 0.75rem; color: var(--muted); margin-top: 2px; }
    .txn-amount { font-family: 'Syne', sans-serif; font-size: 0.95rem; font-weight: 700; white-space: nowrap; text-align: right; }
    .txn-amount.credit { color: var(--accent); }
    .txn-amount.debit  { color: var(--text); }
    .txn-status { font-size: 0.68rem; font-weight: 600; padding: 2px 8px; border-radius: 100px; margin-top: 4px; display: inline-block; }
    .status-done    { background: rgba(0,229,160,0.12); color: var(--accent); }
    .status-pending { background: rgba(255,150,50,0.12); color: var(--orange); }
    .status-failed  { background: rgba(255,85,114,0.12); color: var(--red); }
    .txn-divider { height: 1px; background: var(--border); margin: 8px 0; }

    /* SUMMARY CHIPS */
    .summary-row { display: grid; grid-template-columns: repeat(3,1fr); gap: 16px; margin-bottom: 24px; }
    .summary-card { background: var(--card); border: 1px solid var(--border); border-radius: 18px; padding: 20px 24px; }
    .summary-label { font-size: 0.78rem; color: var(--muted); margin-bottom: 6px; }
    .summary-val { font-family: 'Syne', sans-serif; font-size: 1.4rem; font-weight: 800; letter-spacing: -0.5px; }

    @keyframes fadeUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }
    .anim-1 { animation: fadeUp 0.5s 0.05s ease both; }
    .anim-2 { animation: fadeUp 0.5s 0.12s ease both; }
    .anim-3 { animation: fadeUp 0.5s 0.19s ease both; }
    @media (max-width: 900px) { .sidebar { display: none; } .main { margin-left: 0; padding: 24px 20px 50px; } }
    @media (max-width: 600px) { .summary-row { grid-template-columns: 1fr; } }
  </style>
</head>
<body>
  <aside class="sidebar">
    <form method="post" action="index.jsp" class="sidebar-logo">
      <button type="submit" class="sidebar-logo-btn">
        <span class="logo-mark">&#x26A1;</span>
        <span>PBM PAYFLOW</span>
      </button>
    </form>
    <div class="nav-group-label">Main</div>
    <form method="post" action="dashboard.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F3E0;</span> Dashboard</button></form>
    <form method="post" action="transactions.jsp"><button type="submit" class="nav-item active"><span class="nav-icon">&#x21C4;</span> Transactions<span class="nav-badge">3</span></button></form>
    <form method="post" action="sendMoney.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F4B8;</span> Send Money</button></form>
    <form method="post" action="receive.jsp"><button type="submit" class="nav-item"><span class="nav-icon">&#x1F4E5;</span> Receive</button></form>
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
        <h1>Transactions &#x21C4;</h1>
        <p>All your payment activity in one place.</p>
      </div>
    </div>

    <div class="summary-row anim-2">
      <div class="summary-card">
        <div class="summary-label">Total Received</div>
        <div class="summary-val" style="color:var(--accent);">&#x20B9;<%= total_credit_amount %></div>
      </div>
      <div class="summary-card">
        <div class="summary-label">Total Sent</div>
        <div class="summary-val">&#x20B9;<%= total_debit_amount %></div>
      </div>
      <div class="summary-card">
        <div class="summary-label">Total Transactions</div>
        <div class="summary-val"><%= total_transaction %></div>
      </div>
    </div>

    <div class="filter-bar anim-2">
      <button class="filter-btn active">All</button>
      <button class="filter-btn" >&#x2197; Sent</button>
      <button class="filter-btn">&#x2198; Received</button>
      <button class="filter-btn">&#x23F3; Pending</button>
      <button class="filter-btn">&#x2717; Failed</button>
      <div class="search-box">
        <span>&#x1F50D;</span>
        <input type="text" placeholder="Search transactions..." />
      </div>
    </div>

    <div class="dash-card anim-3">
      <div class="card-header">
        <span class="card-title">Transaction History</span>
        <span style="font-size:0.8rem;color:var(--muted);">June 2026</span>
      </div>
      <div class="txn-list">

       <% if(list!=null){
	   Iterator<transaction_model> itr=list.iterator();
       
	   while(itr.hasNext()){
	       total_transaction++;
		   transaction_model tm=(transaction_model)itr.next();		     
	    if(tm.getTransaction_type().equalsIgnoreCase("debit")){     
         total_debit_amount+=tm.getTransaction_amount();
%>
<div class="txn-item">
            <div class="txn-avatar" style="background:rgba(0,102,255,0.15);">&#x1F9D1;</div>
            <div class="txn-info">
              <div class="txn-name"><%=  tm.getReceiver_name() %></div>
              <div class="txn-date"><%= tm.getTransaction_time() %> &bull; UPI</div>
            </div>
            <div>
              <div class="txn-amount debit">- &#x20B9;<%= tm.getTransaction_amount() %></div>
              <div class="txn-status status-done">&#x2713; <%= tm.getTransaction_status() %> </div>
            </div>
          </div>
<%  } else {  total_credit_amount+=tm.getTransaction_amount(); %>
	 <div class="txn-item">
            <div class="txn-avatar" style="background:rgba(0,229,160,0.12);">&#x1F9D1;</div>
            <div class="txn-info">
              <div class="txn-name"><%= tm.getSender_name() %></div>
              <div class="txn-date"><%= tm.getTransaction_time() %></div>
            </div>
            <div>
              <div class="txn-amount credit">+ &#x20B9;<%= tm.getTransaction_amount() %></div>
              <div class="txn-status status-done">&#x2713; <%= tm.getTransaction_status() %></div>
            </div>
          </div>
	
<%  } } } %>
         

      </div>
    </div>
  </main>
</body>
</html>
