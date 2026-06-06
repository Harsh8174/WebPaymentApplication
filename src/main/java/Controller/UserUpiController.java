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
		HttpSession session = request.getSession(false);

		System.out.println("Session = " + session);
		System.out.println("User = " + session.getAttribute("User"));
		String action=request.getParameter("bank_submit");
		System.out.println("action value = "+action);
		if(action.equalsIgnoreCase("accountcreate")) {
			 User_Bankdetails  u=new User_Bankdetails();
		     u.setName(request.getParameter("user_name"));
		     u.setBank_name(request.getParameter("Bank_name"));
		     u.setAccount_number(Long.parseLong(request.getParameter("account_number")));
		     u.setIfsc(request.getParameter("ifsc_code"));
			 u.setAccount_type(request.getParameter("account_type"));
			 u.setMobile_number(request.getParameter("mobile_number"));
			 String message = UserBankDao.checkbankdetails(u);
			 request.setAttribute("msg", message);
			 request.setAttribute("flag", "true");
			 request.getRequestDispatcher("Bankvalidation.jsp").forward(request, response);
		}
	}

}
