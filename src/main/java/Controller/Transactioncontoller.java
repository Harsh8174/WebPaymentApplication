package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.Dao;
import DAO.DaoTransaction;
import Model.User;
import Model.User_Upi;
import Model.transaction_model;

/**
 * Servlet implementation class Transactioncontoller
 */
@WebServlet("/Transaction")
public class Transactioncontoller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	     String action=request.getParameter("submit");
	     if(action.equalsIgnoreCase("sendmoney")) {
	    	String receiver_upi_id=request.getParameter("recipientUpi"); 
	    	double amount=Double.parseDouble(request.getParameter("amount"));
	    	String upi_pin=request.getParameter("upiPin");
	    	 boolean upi_id=Dao.Checkupiid(receiver_upi_id);
	    	 HttpSession session=request.getSession();
	    	 User_Upi upi_sender=(User_Upi)session.getAttribute("User_upi");
	    	 String sender_upi_id=upi_sender.getUpi_id();
	    	 if(upi_id) {
	    		 if(!sender_upi_id.equalsIgnoreCase(receiver_upi_id)) {
	    		 String message =DaoTransaction.sendmoney(sender_upi_id, receiver_upi_id, amount, upi_pin);
	    		 if(message.equalsIgnoreCase("Execeeding Transaction Limit")) {
	    			 request.setAttribute("msg", message);
		    		 request.getRequestDispatcher("sendMoney.jsp").forward(request, response);
	    		 }else if(message.equalsIgnoreCase("Low Bank Balance")) {
	    			 request.setAttribute("msg", message);
		    		 request.getRequestDispatcher("sendMoney.jsp").forward(request, response);
	    		 }else if(message.equalsIgnoreCase("UPI PIN Incorrect")) {
	    			 request.setAttribute("msg", message);
		    		 request.getRequestDispatcher("sendMoney.jsp").forward(request, response);
	    		 }else if(message.equalsIgnoreCase("Transaction failure")) {
	    			 request.setAttribute("msg", message);
		    		 request.getRequestDispatcher("sendMoney.jsp").forward(request, response);
	    		 }else{
	    			 request.setAttribute("msg", message);
	    			 session.setAttribute("txn_success", "true");
	    			 session.setAttribute("txn_amount",  amount);      
	    			 session.setAttribute("txn_to",  receiver_upi_id   ); // recipient UPI
	    			 session.setAttribute("txn_ref",     "PBM" + System.currentTimeMillis());
	    			 //session.removeAttribute("transaction_list");
	    			 //User u=(User)session.getAttribute("User");
	    			
			           //session.setAttribute("transaction_list", list);
		    		    response.sendRedirect("dashboard.jsp");
			         //  request.getRequestDispatcher("dashboard.jsp").forward(request, response);
	    		 }
	    		 }
	    		 else {
	    			 request.setAttribute("msg", "Upi id Invalid!");
		    		 request.getRequestDispatcher("sendMoney.jsp").forward(request, response);
	    		 }
	    	 }
	    	 else {
	    		 request.setAttribute("msg", "Upi id not exist!");
	    		 request.getRequestDispatcher("sendMoney.jsp").forward(request, response);
	    	 }
	     }
	}

}
