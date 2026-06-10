<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
 
    body {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 2rem 1rem;
      background: #f4f3ef;
      font-family: 'DM Sans', sans-serif;
    }
 
    .login-card {
      background: #ffffff;
      border: 1px solid #e0ddd5;
      border-radius: 12px;
      padding: 2.5rem 2rem;
      width: 100%;
      max-width: 420px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    }
 
    .login-header {
      text-align: center;
      margin-bottom: 2rem;
    }
 
    .login-header .icon {
      width: 52px;
      height: 52px;
      background: #E1F5EE;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 14px;
    }
 
    .login-header .icon svg {
      width: 24px;
      height: 24px;
      stroke: #1D9E75;
      fill: none;
      stroke-width: 2;
      stroke-linecap: round;
      stroke-linejoin: round;
    }
 
    .login-header h1 {
      font-family: 'DM Serif Display', serif;
      font-size: 26px;
      font-weight: 400;
      color: #1a1a1a;
      letter-spacing: -0.3px;
      margin-bottom: 6px;
    }
 
    .login-header p {
      font-size: 14px;
      color: #888;
    }
 
    .accent-bar {
      width: 40px;
      height: 3px;
      background: #1D9E75;
      border-radius: 99px;
      margin: 10px auto 0;
    }
 
    .field-group {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
 
    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }
 
    .field label {
      font-size: 13px;
      font-weight: 500;
      color: #555;
    }
 
    .field label span {
      color: #D85A30;
      margin-left: 2px;
    }
 
    .field input {
      font-family: 'DM Sans', sans-serif;
      font-size: 14px;
      height: 44px;
      padding: 0 14px;
      border: 1px solid #ccc;
      border-radius: 8px;
      background: #fff;
      color: #1a1a1a;
      width: 100%;
      outline: none;
      transition: border-color 0.15s, box-shadow 0.15s;
    }
 
    .field input:focus {
      border-color: #1D9E75;
      box-shadow: 0 0 0 3px rgba(29, 158, 117, 0.12);
    }
 
    .field input::placeholder { color: #bbb; font-weight: 300; }
 
    /* email validation feedback — pure CSS */
    .field input[type="email"]:not(:placeholder-shown):invalid {
      border-color: #D85A30;
      box-shadow: 0 0 0 3px rgba(216, 90, 48, 0.1);
    }
 
    .field input[type="email"]:not(:placeholder-shown):valid {
      border-color: #1D9E75;
      box-shadow: 0 0 0 3px rgba(29, 158, 117, 0.1);
    }
 
    /* show/hide hint messages using sibling selectors */
    .hint { display: none; font-size: 12px; margin-top: 2px; }
    .hint-error { color: #D85A30; }
    .hint-ok    { color: #1D9E75; }
 
    .field input[type="email"]:not(:placeholder-shown):invalid ~ .hint-error { display: block; }
    .field input[type="email"]:not(:placeholder-shown):valid  ~ .hint-ok    { display: block; }
 
    .remember-forgot {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-top: 2px;
    }
 
    .remember {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      color: #555;
      cursor: pointer;
    }
 
    .remember input[type="checkbox"] {
      width: 16px;
      height: 16px;
      accent-color: #1D9E75;
      cursor: pointer;
    }
 
    .forgot-link {
      font-size: 13px;
      color: #1D9E75;
      text-decoration: none;
      font-weight: 500;
    }
 
    .forgot-link:hover { text-decoration: underline; }
 
    .submit-btn {
      width: 100%;
      height: 46px;
      margin-top: 4px;
      background: #1D9E75;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-family: 'DM Sans', sans-serif;
      font-size: 15px;
      font-weight: 500;
      cursor: pointer;
      letter-spacing: 0.2px;
    }
 
    .submit-btn:hover  { background: #0F6E56; }
    .submit-btn:active { background: #085041; }
 
    .signup-link {
      text-align: center;
      margin-top: 1.25rem;
      font-size: 13px;
      color: #888;
    }
 
    .signup-link a {
      color: #1D9E75;
      text-decoration: none;
      font-weight: 500;
    }
 
    .signup-link a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<% String useremail=(String)request.getAttribute("Useremail"); %>
  <%@ include file="HTML/ResetPassword.html" %> 
 
</body>
</html>