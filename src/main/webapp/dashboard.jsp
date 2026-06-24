<%@page import="DAO.DaoTransaction"%>
<%@page import="Model.transaction_model"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="Model.User_Upi"%>
<%@page import="Model.User_Bankdetails"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="Model.User"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payflow &mdash; Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet"/>
 
<link rel="stylesheet" href="HTML/dashboard.css">
</head>
<body>
<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0); %>
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
System.out.println(imagename);


List<transaction_model> list=DaoTransaction.transactionhistory(u.getId());
int total_transaction=0;
double total_debit_amount=0;
double total_credit_amount=0;
int count_credit=0;
String Transaction_type="";
%>
 
<% if(list!=null){
	   Iterator<transaction_model> itr=list.iterator();
       
	   while(itr.hasNext()){
	       total_transaction++;
		   transaction_model tm=(transaction_model)itr.next();		     
	        Transaction_type=tm.getTransaction_type();
		   if(tm.getTransaction_type().equalsIgnoreCase("debit")){     
         total_debit_amount+=tm.getTransaction_amount();
%>

<%  } else {  total_credit_amount+=tm.getTransaction_amount(); %>
<%  } }    
} %>
<%  int credit_percentage =0;
    int debit_percentage=0; 
    System.out.println(total_credit_amount);
    System.out.println(total_debit_amount);
    double transaction_amount=total_credit_amount+total_debit_amount;
    credit_percentage=(int)((total_credit_amount/transaction_amount)*100);
     System.out.println(credit_percentage);
     debit_percentage=(int)((total_debit_amount/transaction_amount)*100);	  
	 System.out.println(credit_percentage);%>         
<%
if(session.getAttribute("User") == null){
    response.sendRedirect("index.jsp");
    return;
}
%>
<%
    String txnSuccess = (String) session.getAttribute("txn_success");
    Double txnAmount  = (Double) session.getAttribute("txn_amount");
    String txnTo      = (String) session.getAttribute("txn_to");
    String txnRef     = (String) session.getAttribute("txn_ref");
    
    // Clear after reading so it doesn't show again on refresh
    session.removeAttribute("txn_success");
    session.removeAttribute("txn_amount");
    session.removeAttribute("txn_to");
    session.removeAttribute("txn_ref");
%>
<%@ include file="HTML/dashboard.html" %>
 <script>
  function closeModal() {
    document.getElementById('successModal').classList.remove('show');
    // Show toast after modal closes
    var t = document.getElementById('toast');
    t.classList.add('show');
    setTimeout(function() { t.classList.remove('show'); }, 3500);
  }

  // Auto-open modal if server set txn_success
  <% if ("true".equals(txnSuccess)) {   u_bank.setBankbalance(u_bank.getBankbalance()-txnAmount);   %>
    
      var mybalance=document.getElementById('mybalance');
     window.addEventListener('DOMContentLoaded', function() {
      document.getElementById('successModal').classList.add('show');
      mybalance.innerHTML=<%= u_bank.getBankbalance() %>
    });
  <% } %>
  
</script>
<%

%>

</body>
<script>

 function displaydate(){
  var timedisplay=document.getElementById('timedisplay');
	 var date=new Date();
     var time=date.getHours();
     if(time>=12 && time<17 ){
    	 timedisplay.innerHTML="Good Afternoon";
     }
     else if(time>=17){
    	 timedisplay.innerHTML="Good Evening";
     }else if(time>=0 && time<=4){
    	 timedisplay.innerHTML="Good Night";
     }
     else{
    	 timedisplay.innerHTML="Good Morning"; 
     }
      
 }
displaydate();


function sendjsp(){
	window.location.href="sendMoney.jsp";
}
function transactionjsp(){
	window.location.href="transactions.jsp";
}
function recievejsp(){
	window.location.href="receive.jsp";
}
</script>


</html>