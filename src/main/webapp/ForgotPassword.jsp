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
String mail=(String)request.getAttribute("Useremail");
System.out.println(mail);
Integer System_otp = (Integer)request.getAttribute("Systemotp");
System.out.println("System_otp :"+System_otp);
int s_otp=System_otp.intValue();
System.out.println("S_otp :"+s_otp);
%>
<% 
if(mail!=null){
if(mail.equalsIgnoreCase("Email Does Not Exist!")){System.out.println("if call 1");
%>
<h3 style="color:red; position:absolute; top:20px; left:50%; transform:translateX(-50%);">
<%= mail%>
</h3>
<%@ include file="HTML/Forgotpassword.html" %>
<% } else{  %>
    <% String msg=(String)request.getAttribute("msg"); 
    
    if(msg.equalsIgnoreCase("OTP Sended to Your Email ID")){ System.out.println("if call 2");
    %>
    <h3 style="color:red; position:absolute; top:20px; left:50%; transform:translateX(-50%);">
<%= msg +" "+ mail%>
</h3>
<%@ include file="HTML/GenerateOtp.html" %>
 <%}else if(msg.equalsIgnoreCase("OTP Resended to Your Email ID")){ System.out.println("if call 4");
	 System.out.println(mail);
	 System.out.println("Inside resended"); %>
<script>
 window.onload = function (){
	 console.log("called");
	 var  btn=document.getElementById('verify-button');
	 btn.innerHTML="Verify";
	 var regenerate = document.getElementById('button-regenerate');
	 regenerate.value="verifyotp"; 
 }
 </script>
 <h3 style="color:red; position:absolute; top:20px; left:50%; transform:translateX(-50%);">
<%= msg +" "+ mail%>
</h3>
<%@ include file="HTML/GenerateOtp.html" %>
<% } else if(msg.equalsIgnoreCase("Invalid Otp")) { System.out.println("if call 3");
	 mail=(String)request.getAttribute("Useremail");
	System.out.println("Invalid otp:" + mail);
 %>
 <script>
 window.onload = function (){
	 console.log("called");
	 var  btn=document.getElementById('verify-button');
	 btn.innerHTML="Re-Generate OTP";
	 var regenerate = document.getElementById('button-regenerate');
	 regenerate.value="resendotp";
	 
 }
 </script>
<h3 style="color:red; position:absolute; top:20px; left:50%; transform:translateX(-50%);">
<%= msg %>
</h3>
<%@ include file="HTML/GenerateOtp.html" %>

<%} %>
   
<%}} %>



 
 
</body>
</html>