<%@page import="Model.User"%>
<%@page import="DAO.Dao"%>
<%@page import="Model.User_Bankdetails"%>
<%@page import="DAO.UserBankDao"%>
<%@page import="Model.User_Upi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="HTML/success.css">

</head>
<body>
   <% String message = (String)request.getAttribute("msg");
      User_Upi u1 = (User_Upi)request.getAttribute("User_upi");
      User u = (User)session.getAttribute("User");
      User_Bankdetails u_bank=(User_Bankdetails)session.getAttribute("user_bank");
     System.out.println(u1.getUpi_id()); 
     System.out.println(u_bank.getName()); 
     System.out.println(u_bank.getBank_name()); 
      %> 
   <%@ include file="HTML/Navigation.html" %>   
   <%@ include file="HTML/Success.html" %>
   <script src="HTML/scriptsuccess.js" ></script>
   <script>const userName = "<%= u.getUsername() %>" ;
   const showSuccess = true;
   </script>
</body>
</html>