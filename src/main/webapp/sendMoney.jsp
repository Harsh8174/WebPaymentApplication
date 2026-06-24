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
  boolean display=false;
  String message="";
  String msg=(String)request.getAttribute("msg");
  if(msg!=null)
  {
	  message=msg;
	  display=true;
  }
%>
<%@ include file="HTML/sendMoney.html"   %>
<script>
var display= <%= display %>; 
var upiidnotexist=document.getElementById('upiidnotexist');
if(display){
	 upiidnotexist.style.color='red';
	upiidnotexist.innerHTML = "<%=  message  %> "
}
window.onload
</script>