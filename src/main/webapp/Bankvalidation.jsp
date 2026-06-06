<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="Model.User" pageEncoding="UTF-8"%>

<%
User u = (User)session.getAttribute("User");

String message = (String)request.getAttribute("msg");

boolean bankVerified = false;
if(message != null &&
   message.equalsIgnoreCase("Bank Account Linked Successfully")){
    bankVerified = true;
}

String upi_id_message=(String)request.getAttribute("upi_id_msg");
String display_message_boolean=(String)request.getAttribute("display");
String flag = (String)request.getAttribute("flag");
if(upi_id_message!=null){
	bankVerified =true;
	System.out.println("set_up : "+bankVerified);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UPI Account Creation</title>

<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="HTML/UPIAccountcreation.css">
<style>
.toast-msg {
  display: flex;
  align-items: center;
  gap: 10px;
  position: fixed;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 99999;
  padding: 12px 20px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 500;
  max-width: 480px;
  width: max-content;
  box-shadow: 0 2px 12px rgba(0,0,0,0.12);
  animation: toastSlide 0.3s ease;
}
.toast-error  { background: #fff1f0; color: #c0392b; border: 1px solid #f5c6c6; }
.toast-success{ background: #f0fdf4; color: #1a7a3c; border: 1px solid #b7e4c7; }
.toast-close  { cursor:pointer; margin-left:8px; opacity:0.6; background:none;
                border:none; color:inherit; font-size:18px; line-height:1; padding:0; }
.toast-close:hover { opacity:1; }
@keyframes toastSlide {
  from { opacity:0; transform:translateX(-50%) translateY(-10px); }
  to   { opacity:1; transform:translateX(-50%) translateY(0); }
}
</style>
</head>
<body>

<%@ include file="HTML/Navigation.html" %>


    <%-- Show message from servlet --%>
   <% if(message != null){ 
   String toastClass = bankVerified ? "toast-success" : "toast-error";
   String toastIcon  = bankVerified ? "✓" : "✕";
%>
  <div class="toast-msg <%= toastClass %>" id="toastMsg" role="alert">
    <span><%= toastIcon %></span>
    <span><%= message %></span>
    <button class="toast-close" onclick="document.getElementById('toastMsg').remove()"
            aria-label="Close">&times;</button>
  </div>
  <script>
    setTimeout(() => {
      const t = document.getElementById('toastMsg');
      if(t) t.remove();
    }, 4000);
  </script>
<% } %>

    <% if(bankVerified){ %>
            <% boolean flag_value = Boolean.parseBoolean(flag); %>
          <% if (flag_value) {%>
          <%@ include file="HTML/upisetup.html" %>
         <%} else{%>
         <%@ include file="HTML/Setpin.html" %>
         <% } %>
    <% if(display_message_boolean != null){
    	System.out.println(display_message_boolean);
    	 boolean display=Boolean.parseBoolean(display_message_boolean);
    	 if(display){
    	//id not exist
    	System.out.println("value of display :"+ display);
    	 String toastClass = display ? "toast-success" : "toast-error";
    	 String toastIcon  = display ? "✓": "✕";  
    	%>
        <div class="toast-msg <%= toastClass %>" id="toastMsg" role="alert">
    <span><%= toastIcon %></span>
    <span><%= upi_id_message %></span>
    <button class="toast-close" onclick="document.getElementById('toastMsg').remove()"
            aria-label="Close">&times;</button>
  </div>
  <script>
    setTimeout(() => {
      const t = document.getElementById('toastMsg');
      if(t) t.remove();
    }, 4000);
  </script>
  <%  } else{ //id  exist
	  System.out.println("value of display :"+ display);
	  String toastClass = display ? "toast-success" : "toast-error";
 	 String toastIcon  = display ? "✓": "✕";  %>
             <div class="toast-msg <%= toastClass %>" id="toastMsg" role="alert">
    <span><%= toastIcon %></span>
    <span><%= upi_id_message %></span>
    <button class="toast-close" onclick="document.getElementById('toastMsg').remove()"
            aria-label="Close">&times;</button>
  </div>
  <script>
    setTimeout(() => {
      const t = document.getElementById('toastMsg');
      if(t) t.remove();
    }, 4000);
  </script>
<% } }%>

    <% } else {  %>
     
        <%@ include file="HTML/Bankvalidationform.html" %>

    <% } %>

<script>
const userName = "<%= u.getUsername() %>" ;
var bankVerified = <%= bankVerified %>
var message = "<%= message %>";

	var currentStep = 3;
	var upiCreated = <%= (flag != null && !Boolean.parseBoolean(flag)) %>;
console.log(message);
</script>
<script src="HTML/script.js"></script>

</body>
</html>
