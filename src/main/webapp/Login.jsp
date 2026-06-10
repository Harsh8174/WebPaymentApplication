<%@page import="Model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<body>
<% 
  User u=null;
if(request.getAttribute("msg")!=null){
  String msg=(String)request.getAttribute("msg");

%>
<h3 id="server-msg"  style="color:red; position:absolute; top:20px; left:50%; transform:translateX(-50%);">
<%= msg%>
</h3>
<%
}
%>
<%@ include file="HTML/Login.html" %>





</body>
</html>