<%@page import="Model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<% 
if(request.getAttribute("msg")!=null){
  request.getRequestDispatcher("Login.jsp").forward(request, response);
}
%>
<%@ include file="HTML/Registration.html" %>
</body>
