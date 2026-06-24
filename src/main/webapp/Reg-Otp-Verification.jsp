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
User u=(User)session.getAttribute("User");
String mail =u.getEmail();
Integer System_otp = (Integer)session.getAttribute("Systemotp");
System.out.println("System_otp :"+System_otp);
int s_otp=System_otp.intValue();
System.out.println("S_otp :"+s_otp);
%>
<% 
if(u!=null){
	String msg=(String)session.getAttribute("msg");
	if(msg.equalsIgnoreCase("OTP Sended to Your Email ID"))
	{
		
	%>
	 <h3 style="color:red; position:absolute; top:20px; left:50%; transform:translateX(-50%);">
<%= msg +" "+ mail%>
</h3>
	<%@ include file="HTML/RegOtpGenerator.html" %>
	<% } else {	   
		String msg_failure=(String)session.getAttribute("msg");
	%>
	<h3 style="color:red; position:absolute; top:20px; left:50%; transform:translateX(-50%);">
<%= msg%>
</h3>

<%@ include file="HTML/RegOtpGenerator.html" %>
	<Script>
	window.onload=function(){
		var  btn=document.getElementById('verify-button');
		 btn.innerHTML="Re-Generate OTP";		 
		 var  btn_gen=document.getElementById('button-regenerate');
		 btn_gen.value="resendotp";
	}
	</Script>
	<%} %>
<%
}
%>
</body>
</html>