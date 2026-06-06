<%@ page import="Model.User" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% User u=(User) session.getAttribute("User"); System.out.println(u);
%>
  <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Payflow — UPI Setup</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="HTML/UPIAccountcreation.css">
  
</head>
<body>

<%@ include file="HTML/Navigation.html" %>
<%@  include file="HTML/Welcome.html" %>
<%@ include file= "HTML/Bankvalidationform.html" %>
<script>const userName = "<%= u.getUsername() %>" 

</script>
  <script src="HTML/welcome.js"></script>
  <script src="HTML/script.js"></script>
</body>

</html>
  