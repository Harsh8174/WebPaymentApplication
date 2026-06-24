package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBCONNECTION.Dbconnection;
import Model.User;
import Model.User_Bankdetails;
import Model.User_Upi;

public class UserBankDao {
   public static String checkbankdetails(User_Bankdetails u) {
	      try {
	    	 Connection conn= Dbconnection.Connect();
             PreparedStatement pst= conn.prepareStatement("select * from upi_user_bankdetails");	
             ResultSet rst= pst.executeQuery();
             String message="";
             System.out.println(u);
             while(rst.next()){
            	 if(           u.getName().equalsIgnoreCase(rst.getString("user_name"))
            			    && u.getBank_name().equalsIgnoreCase(rst.getString("bank_name"))
            	            && u.getAccount_number() == rst.getLong("account_number")
            	            && u.getIfsc().equalsIgnoreCase(rst.getString("ifsc"))
            	            && u.getAccount_type().equalsIgnoreCase(rst.getString("account_type"))
            	            && u.getMobile_number().equalsIgnoreCase(rst.getString("mobile_number"))) {
            		        message = "Bank Account Linked Successfully";
            	            break;
            	        }
            	        else {
            	            message = "Bank Details Mismatch";
            	        }
            	    }
             System.out.println(message);
               
             return message;   
	      }
	      catch (Exception e) {
			// TODO: handle exception
		}
	      return "";
   }
  public static User_Bankdetails getuserbankdetails(User u){
	  try {
		  Connection conn= Dbconnection.Connect();
          PreparedStatement pst= conn.prepareStatement("select * from upi_user_bankdetails where user_id=?");      
          pst.setInt(1,u.getId());
          ResultSet rst= pst.executeQuery();
          User_Bankdetails u_bank=null;
          if(rst.next()) {
        	  u_bank=new User_Bankdetails();
      		  u_bank.setName(rst.getString("user_name"));
      		  u_bank.setBank_name(rst.getString("bank_name"));
      		  u_bank.setAccount_number(rst.getLong("account_number"));
      		  u_bank.setIfsc(rst.getString("ifsc"));
      		  u_bank.setAccount_type(rst.getString("account_type"));
      		  u_bank.setMobile_number(rst.getString("mobile_number"));
      		  u_bank.setBankbalance(rst.getDouble("bank_balance"));
      		  return u_bank;
          }
	  }
	  catch (Exception e) {
		// TODO: handle exception
		  e.printStackTrace();
	}
	  return null;
  }
  
  public static void set_userid(User_Bankdetails bank_user) {
      		try {
      			 Connection conn= Dbconnection.Connect();
      	         PreparedStatement pst= conn.prepareStatement("update upi_user_bankdetails set user_id=? where account_number=?");
      	         pst.setInt(1, bank_user.getUser_id());
      	         pst.setLong(2, bank_user.getAccount_number());
      	         pst.executeUpdate();
      		}
      		catch (Exception e) {
				e.printStackTrace();
			}
  } 

}
