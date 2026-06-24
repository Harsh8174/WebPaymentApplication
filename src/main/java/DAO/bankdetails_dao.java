package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import DBCONNECTION.Dbconnection;
import Model.User_Bankdetails;

public class bankdetails_dao {
           public static void set_user_bank_details(User_Bankdetails u) {
        	  Connection conn= Dbconnection.Connect();
        	  try {
        		  PreparedStatement pst=conn.prepareStatement("insert into upi_user_bankdetails(user_name,bank_name,account_number,ifsc,account_type,mobile_number,bank_balance) values(?,?,?,?,?,?,?)");
        	      pst.setString(1, u.getName());
        	      pst.setString(2, u.getBank_name());
        	      pst.setLong(3, u.getAccount_number());
        	      pst.setString(4, u.getIfsc());
        	      pst.setString(5, u.getAccount_type());
        	      pst.setString(6, u.getMobile_number());
        	      pst.setDouble(7, u.getBankbalance());
        	      pst.executeUpdate();
        	  }
        	  catch (Exception e) {
				// TODO: handle exception
			e.printStackTrace();
        	  }
           }
}
