package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.Dao;
import Model.User;

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
			   u.setUsername(username);
			   u.setEmail(useremail);
			   u.setContact(contact);
			   u.setGender(gender);
			   boolean exist = Dao.checkemail(useremail);
			   if(!exist) {
				   request.setAttribute("msg", "Account Already Exist");
				   request.getRequestDispatcher("Register.jsp").forward(request, response);
			   }
			   else {
				   Dao.createaccount(u);
				    request.setAttribute("msg", "Account Created successfully");
				   request.getRequestDispatcher("Login.jsp").forward(request, response);
			   }
		   }else if(value.equalsIgnoreCase("login")){
				   String loginuseremail=request.getParameter("useremail");
				   System.out.println(loginuseremail);
				   boolean exist1=Dao.checkemail(loginuseremail);
				   if(exist1==false) {
					  User login_user=Dao.getuser(loginuseremail);
					  HttpSession session=request.getSession();
					  session.setAttribute("User", login_user);
	                  request.getRequestDispatcher("UPIAccountcreation.jsp").forward(request, response);
	                  
				   }
				   else {
					   request.setAttribute("msg", "Account Email invalid!");
					   request.getRequestDispatcher("Login.jsp").forward(request, response);	   
				   }
			   }
		   }
		  
		  catch (Exception e) {
			// TODO: handle exception
			  e.printStackTrace();
		}
		  
		   
	}
}
