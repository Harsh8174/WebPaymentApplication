package Controller;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.Dao;
import DAO.DaoTransaction;
import DAO.UserBankDao;
import Emailservice.EmailService;
import Model.User;
import Model.User_Bankdetails;
import Model.User_Upi;
import Model.transaction_model;

/**
 * Servlet implementation class Usercontroller
 */
@WebServlet("/userregister")
public class Usercontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		  try {
		   String value=request.getParameter("submit");
		   if(value.equalsIgnoreCase("register")) {
			   User u=new User();
			   String username=request.getParameter("username");
			   String useremail=request.getParameter("useremail");
			   long contact=  Long.parseLong(request.getParameter("usercontact"));
			   String gender=request.getParameter("gender");
			   String password =request.getParameter("userpassword");
			   u.setUsername(username);
			   u.setEmail(useremail);
			   u.setContact(contact);
			   u.setGender(gender);
			   u.setPassword(password);
			   boolean exist = Dao.checkemail(useremail);
			   if(!exist) {
				   request.setAttribute("msg", "Account Already Exist");
				   request.getRequestDispatcher("Login.jsp").forward(request, response);
			   }
			   else {
				   Random r=new Random();
				   Integer otp = r.nextInt(111111,999999);
				   EmailService.sendOTP(useremail,otp);
				   HttpSession session=request.getSession();
				   session.setAttribute("User", u);
				   session.setAttribute("Systemotp", otp.intValue());
				   session.setAttribute("msg", "OTP Sended to Your Email ID");
				   request.getRequestDispatcher("Reg-Otp-Verification.jsp").forward(request, response);
			   }
		   }else if(value.equalsIgnoreCase("verifyregotp")) {
			   String p01=request.getParameter("p0");
			   String p02=request.getParameter("p1");
			   String p03=request.getParameter("p2");
			   String p04=request.getParameter("p3");
			   String p05=request.getParameter("p4");
			   String p06=request.getParameter("p5");
			   String finalotp=p01+p02+p03+p04+p05+p06;
			   String system_otp=request.getParameter("system_otp");
			   HttpSession session=request.getSession();
			   User u=(User)session.getAttribute("User");
			   if(finalotp.equalsIgnoreCase(system_otp)) {
				   //System.out.println(u.getEmail());
				   Dao.createaccount(u);
				   request.setAttribute("msg", "Account Created successfully");
				   request.getRequestDispatcher("Login.jsp").forward(request, response);
			   } 
			   else {
			   session.setAttribute("msg","Invalid Otp");
			   session.setAttribute("User", u);
			   session.setAttribute("Systemotp",Integer.parseInt(system_otp));
			   request.getRequestDispatcher("Reg-Otp-Verification.jsp").forward(request, response);
			   }
		   } 			   
		   else if(value.equalsIgnoreCase("login")){
				   String loginuseremail=request.getParameter("useremail");
				   String password = request.getParameter("userpassword");
				   System.out.println(loginuseremail);
				   boolean exist1=Dao.validateemail(loginuseremail);
				   boolean exist2 = Dao.validatepassword(loginuseremail, password);
				   if(exist1==false && exist2==false) {
					  
					  HttpSession oldsession=request.getSession(false);
					  if(oldsession != null) {
						  System.out.println("old created session id:"+oldsession.getId());
						    oldsession.invalidate();
						}
					  HttpSession session=request.getSession(true);
					  User login_user=Dao.getuser(loginuseremail); 
					  session.setAttribute("User", login_user); 
					  System.out.println("New created sessionid:"+session.getId());
					  System.out.println("login user id :"+login_user.getId());
					  if(login_user.isUpi_id_created()) {
						   User_Upi user_upi=Dao.getupiuser(login_user.getId());
						   User_Bankdetails u_bank=UserBankDao.getuserbankdetails(login_user);
						   boolean profileimagestatus=Dao.uploadimgstatus(login_user);
						   if(profileimagestatus) 
						   {
							   String file_name= Dao.getimgfilename(login_user);
							   session.setAttribute("image_name", file_name);
						   }
						   session.setAttribute("profileimage", profileimagestatus);
						   session.setAttribute("User_upi", user_upi);
				           session.setAttribute("user_bank", u_bank);
				           
				           List<transaction_model> list=DaoTransaction.transactionhistory(login_user.getId());
				           session.setAttribute("transaction_list", list);
						   response.sendRedirect("dashboard.jsp");
				           //request.getRequestDispatcher("dashboard.jsp").forward(request, response);
					  }else {
						  System.out.println("Upi id not created");
						  response.sendRedirect("UPIAccountcreation.jsp");
	                  //request.getRequestDispatcher("UPIAccountcreation.jsp").forward(request, response);
					  
				   }
				   }
				   else if(exist1!=false) {
					   System.out.println(exist1);
					   request.setAttribute("msg", "Email Does Not Exist!");
					   request.getRequestDispatcher("Login.jsp").forward(request, response);	   
				   } else{
					   System.out.println(exist2);
					   request.setAttribute("msg", "Password Does Not Match!");
					   request.getRequestDispatcher("Login.jsp").forward(request, response);	   
				   }
			   }else if(value.equalsIgnoreCase("sendotp")){
				   String loginuseremail=request.getParameter("useremail");
				   System.out.println(loginuseremail);
				   boolean exist1=Dao.validateemail(loginuseremail);
				   if(exist1!=false) {
					   System.out.println("sendotp"+exist1);
					    request.setAttribute("Useremail","Email Does Not Exist!");
					   // request.setAttribute("Useremail", "Email Does Not Exist!");
					   request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);	   
				   }else {
					   request.setAttribute("Useremail", loginuseremail);
					   Random r=new Random();
					   Integer otp=r.nextInt(555555);
					   request.setAttribute("Systemotp", otp.intValue());
					   EmailService.sendOTP(loginuseremail, otp);
					   request.setAttribute("msg", "OTP Sended to Your Email ID");
					   request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);    
					   }
				   } else if(value.equalsIgnoreCase("verifyotp")){
					   String p01=request.getParameter("p0");
					   String p02=request.getParameter("p1");
					   String p03=request.getParameter("p2");
					   String p04=request.getParameter("p3");
					   String p05=request.getParameter("p4");
					   String p06=request.getParameter("p5");
					   String finalotp=p01+p02+p03+p04+p05+p06;
					   String system_otp=request.getParameter("system_otp");
					   String loginuseremail=request.getParameter("useremail");
					   if(finalotp.equalsIgnoreCase(system_otp)) {
						   request.setAttribute("Useremail", loginuseremail);
						   request.getRequestDispatcher("ResetPassword.jsp").forward(request, response);	
					   } 
					   else {
					   request.setAttribute("msg","Invalid Otp");
					   request.setAttribute("Useremail", loginuseremail);
					   request.setAttribute("Systemotp",Integer.parseInt(system_otp));
					   request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
					   }
					 }else if(value.equalsIgnoreCase("resendotp")){
						 String loginuseremail=request.getParameter("useremail");
						  // request.setAttribute("Useremail", loginuseremail);
						   Random r=new Random();
						   Integer otp=r.nextInt(555555);
						   request.setAttribute("Systemotp", otp.intValue());
						   EmailService.sendOTP(loginuseremail, otp);
						   request.setAttribute("msg", "OTP Resended to Your Email ID");
						   request.setAttribute("Useremail", loginuseremail);
						   request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);   
					 }	
					 else if(value.equalsIgnoreCase("resetpassword")) {
						      String new_password = request.getParameter("newpassword");
						      String loginuseremail=request.getParameter("useremail");
						      String message= Dao.setnewpassword(loginuseremail, new_password);
						      request.setAttribute("msg", message);
						      request.getRequestDispatcher("Login.jsp").forward(request, response);
					 } else if(value.equalsIgnoreCase("logout")) {
						 
					             
							     response.sendRedirect("index.jsp");
							  
						      
						         
					 }		 
				   
		   }
		  
		  catch (Exception e) {
			// TODO: handle exception
			  e.printStackTrace();
		}
		  
		   
	}
}
