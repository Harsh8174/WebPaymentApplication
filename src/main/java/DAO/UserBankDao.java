package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBCONNECTION.Dbconnection;
import Model.User_Bankdetails;

public class UserBankDao {
   public static String checkbankdetails(User_Bankdetails u) {
	      try {
	    	 Connection conn= Dbconnection.Connect();
             PreparedStatement pst= conn.prepareStatement("select * from upi_user_bankdetails");	
             ResultSet rst= pst.executeQuery();
             String message="";
             while(rst.next()){
            	 if(u.getName().equalsIgnoreCase(rst.getString("user_name"))
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
            	            break;
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
}
