package bankdeatilsinsertion;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserBankDao;
import DAO.bankdetails_dao;
import Model.User_Bankdetails;

/**
 * Servlet implementation class bankdetails
 */
@WebServlet("/bankdetails")
public class bankdetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String Account_holder_name=request.getParameter("acc-holder");
		String Bank_Name=request.getParameter("bank-name");
		String mobile_number=request.getParameter("mobile-number"); 
		long Account_number=Long.parseLong(request.getParameter("acc-number-confirm"));  
		String ifsc=request.getParameter("ifsc");
        String acc_type=request.getParameter("acc-type");
        int bank_balance=Integer.parseInt( request.getParameter("bankbalance")); 
        User_Bankdetails u=new User_Bankdetails();
        u.setName(Account_holder_name);
        u.setBank_name(Bank_Name);
       u.setMobile_number(mobile_number);
       u.setAccount_number(Account_number);
       u.setIfsc(ifsc);
       u.setAccount_type(acc_type);
       u.setBankbalance(bank_balance);
       bankdetails_dao.set_user_bank_details(u);
	}

}
