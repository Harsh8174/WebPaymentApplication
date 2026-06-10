package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.Dao;
import DBCONNECTION.Dbconnection;
import Model.User_Upi;

/**
 * Servlet implementation class Upi_id_Creator
 */
@WebServlet("/UpiCreator")
public class Upi_id_Creator extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String value=request.getParameter("create_upi_id");
		System.out.println("create_upi_id = "+value);
		Connection conn= Dbconnection.Connect();
		if(value.equalsIgnoreCase("set_upi_id")) {
			 User_Upi u=new User_Upi();
			 Dao.setuser(u);
			 String upi_id=request.getParameter("upi_id");
			 int transaction_limit = Integer.parseInt(request.getParameter("trnasaction_limit")); 
			 String email=request.getParameter("email");
			 u.setUpi_id(upi_id+"@payflow");
			 u.setTransaction_limit(transaction_limit);
			 u.setEmail(email);
			 boolean flag=Dao.Checkupiid(u.getUpi_id());
			 if(flag) {
				 System.out.println("flag value :"+flag);
				 request.setAttribute("upi_id_msg", "Upi id already exist");
                 request.setAttribute("display", "false");
                 request.setAttribute("flag", "true");
                 request.getRequestDispatcher("Bankvalidation.jsp").forward(request, response);	 
			 }
                 else {
				 try {				
					    
					    System.out.println("flag value :"+flag);
						PreparedStatement  pst= conn.prepareStatement("insert into user_upi_id_details(upi_id,trnasaction_limit,email) values (?,?,?);");
					    pst.setString(1,u.getUpi_id());
					    pst.setInt(2, u.getTransaction_limit());
					    pst.setString(3, u.getEmail());
					    pst.executeUpdate();
					    System.out.println("data inserted");
					    request.setAttribute("upi_id_msg", "Upi id created successfully");
					    request.setAttribute("display", "true");
					    request.setAttribute("flag", "false");
					    request.getRequestDispatcher("Bankvalidation.jsp").forward(request, response);
					 } catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			 } 
		}
		else if(value.equalsIgnoreCase("set_pin")){
		        User_Upi u =  Dao.getupiuser();
			    String digi_1= request.getParameter("p01");
		    	String digi_2= request.getParameter("p02");
		    	String digi_3= request.getParameter("p03");
		    	String digi_4= request.getParameter("p04");
		    	String digi_5= request.getParameter("p05");
		    	String digi_6= request.getParameter("p06");
		    	String final_pin=digi_1+digi_2+digi_3+digi_4+digi_5+digi_6;
		    	String db_card_digit = request.getParameter("dbcard_digit");
		    	String exp_date = request.getParameter("card_exp_date");
		    	u.setUpi_pin(final_pin);
		    	u.setCard_digit(db_card_digit);
		    	u.setExpiry_date(exp_date);
		    	try {
		    		System.out.println("executing inside");
		    		PreparedStatement pst1=conn.prepareStatement("select * from user_upi_id_details where upi_id=?");		    		  
		    		pst1.setString(1, u.getUpi_id());
		    		System.out.println(u.getUpi_id());
		    		 ResultSet rst= pst1.executeQuery();
		    		 if(rst.next()) {
		    			 System.out.println("UPI ID Found");
		    		 pst1=conn.prepareStatement("update user_upi_id_details" +" set upi_pin=?,card_digit=?,expiry_date=?" +" where upi_id=?");
		    		 pst1.setString(1, u.getUpi_pin());
		    		 pst1.setString(2, u.getCard_digit());
		    		 pst1.setString(3, u.getExpiry_date());
		    		 pst1.setString(4, u.getUpi_id());
		    		 pst1.executeUpdate();
		    		 request.setAttribute("User_upi", u);
		    		 request.setAttribute("msg", "Account created successfully");
		    		 request.getRequestDispatcher("Account_Creation_Successful.jsp").forward(request, response);
		    		 }else {System.out.println("not UPI ID Found");}
		    		 }catch (Exception e) {
					// TODO: handle exception
		    		e.printStackTrace();
				}
		}
	} 

}
