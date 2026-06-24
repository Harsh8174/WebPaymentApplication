package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.Dao;
import DAO.UserBankDao;
import Model.User;
import Model.User_Bankdetails;

/**
 * Servlet implementation class UserUpiController
 */
@WebServlet("/UpiController")
public class UserUpiController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		System.out.println("current user  Session id= " + session.getId());
		String action=request.getParameter("bank_submit");
		//System.out.println("action_value_bank form = "+action);
		if(action.equalsIgnoreCase("accountcreate")) {
			 User_Bankdetails  u=new User_Bankdetails();
			 int user_id=Integer.parseInt(request.getParameter("user_id")); 
			 u.setUser_id(user_id);
		     u.setName(request.getParameter("user_name"));
		     u.setBank_name(request.getParameter("Bank_name"));
		     u.setAccount_number(Long.parseLong(request.getParameter("account_number")));
		     u.setIfsc(request.getParameter("ifsc_code"));
			 u.setAccount_type(request.getParameter("account_type"));
			 u.setMobile_number(request.getParameter("mobile_number"));
			 String message = UserBankDao.checkbankdetails(u);
			 request.setAttribute("msg", message);			 
			 if(message.equalsIgnoreCase("Bank Account Linked Successfully")) {
				 User user=(User)session.getAttribute("User");
				 System.out.println("current user id : "+user_id); 
				 UserBankDao.set_userid(u);
			     u=UserBankDao.getuserbankdetails(user);
			     System.out.println("Upicontroller bank user:"+u);
				 session.setAttribute("user_bank", u);
				 request.setAttribute("flag", "true");
				// response.sendRedirect("Bankvalidation.jsp");
				 request.getRequestDispatcher("Bankvalidation.jsp").forward(request, response);
			 }else {
				 request.setAttribute("flag", "false");
			     // response.sendRedirect("Bankvalidation.jsp");
				 request.getRequestDispatcher("Bankvalidation.jsp").forward(request, response);
			 }
			 }
		
	}

}
