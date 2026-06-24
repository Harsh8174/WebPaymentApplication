package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;



import DBCONNECTION.Dbconnection;
import Model.User;
import Model.User_Bankdetails;
import Model.User_Upi;
import Model.transaction_model;

public class DaoTransaction {
        public static String sendmoney(String sender_upi_id,String Receiver_upi_id,double amount,String sender_upi_pin){
              Connection conn=Dbconnection.Connect();
              User_Upi user_upi_sender=null;
              User u_sender=null;
              User u_receiver=null;
              User_Bankdetails user_bank_sender=null;
              User_Bankdetails user_bank_receiver=null;
              try {
            	  PreparedStatement pst=conn.prepareStatement("select * from  user_upi_id_details where upi_id=?");
            	  pst.setString(1, sender_upi_id);
            	  ResultSet rst=pst.executeQuery();
            	  if(rst.next()) {
            		  
            		  u_sender=new User();
            		  user_upi_sender=new User_Upi();
            		  u_sender.setId(rst.getInt("user_id"));
            		  user_upi_sender.setTransaction_limit(rst.getDouble("transaction_limit"));
            		  user_upi_sender.setUpi_pin(rst.getString("upi_pin"));
            		  
            	  }
            	  if(amount > user_upi_sender.getTransaction_limit()) {
            		  return "Execeeding Transaction Limit";
            	  }
            	  else {
            		  pst=conn.prepareStatement("select * from  upi_user_bankdetails where user_id=?");
            		  pst.setInt(1, u_sender.getId());
                	  rst=pst.executeQuery();
            		  if(rst.next()) {
            			  user_bank_sender=new User_Bankdetails();
            	          user_bank_sender.setBank_name(rst.getString("Bank_name"));
            			  user_bank_sender.setBankbalance(rst.getDouble("bank_balance"));
            		  }
                	  if(amount>user_bank_sender.getBankbalance()) {
                		  return "Low Bank Balance";
                	  }
                	  else {
            		  pst=conn.prepareStatement("select * from  user_upi_id_details where upi_id=?");
            		  pst.setString(1, Receiver_upi_id);
                	  rst=pst.executeQuery();
                	  if(rst.next()) {
                		  u_receiver=new User();
                		  u_receiver.setId(rst.getInt("user_id"));
                		  
                	  }
                	   if(!sender_upi_pin.equalsIgnoreCase(user_upi_sender.getUpi_pin())){
                		   return "UPI PIN Incorrect";
                	   }   
                	   else {System.out.println("upi pin correct");
                		   pst=conn.prepareStatement("select * from  upi_user_bankdetails where user_id=?");
                		   pst.setInt(1, u_receiver.getId());
                		   rst=pst.executeQuery();
                		   if(rst.next()) {
                			   user_bank_receiver=new User_Bankdetails();
                			   user_bank_receiver.setBankbalance(rst.getDouble("bank_balance"));
                			   user_bank_receiver.setBank_name(rst.getString("bank_name"));
                		   }
                		   double sender_balance_afterdebit=user_bank_sender.getBankbalance()-amount;
                		   double receiver_balance_aftercredit=user_bank_receiver.getBankbalance()+amount;
                		   pst=conn.prepareStatement("update upi_user_bankdetails set bank_balance=? where user_id=?");
                		   pst.setDouble(1, sender_balance_afterdebit);    
                		   pst.setInt(2, u_sender.getId());
                		   int row1=pst.executeUpdate();
                		   pst=conn.prepareStatement("update upi_user_bankdetails set bank_balance=? where user_id=?");
                		   pst.setDouble(1,receiver_balance_aftercredit);    
                		   pst.setInt(2, u_receiver.getId());
                		   int row2=pst.executeUpdate();
                		   Timestamp d= Timestamp.valueOf( LocalDateTime.now());  
                		   if(row1==1 && row2==1) {
                			  //sender transaction entry
                			   pst=conn.prepareStatement("insert into upi_transaction(user_id,sender_upi_id,sender_bank_name,receiver_upi_id,receiver_bank_name,Transaction_time,Transaction_amount,Transaction_status,Transaction_type) values(?,?,?,?,?,?,?,?,?);");   
                			   pst.setInt(1, u_sender.getId());
                			   pst.setString(2,sender_upi_id);
                			   pst.setString(3, user_bank_sender.getBank_name());
                			   pst.setString(4,Receiver_upi_id);
                			   pst.setString(5, user_bank_receiver.getBank_name());
                			   pst.setTimestamp(6, d);
                			   pst.setDouble(7, amount);
                			   pst.setString(8, "Success");
                			   pst.setString(9, "Debit");
                			   int row=pst.executeUpdate();
                			   //receiver transaction entry
                			   pst=conn.prepareStatement("insert into upi_transaction(user_id,sender_upi_id,sender_bank_name,receiver_upi_id,receiver_bank_name,Transaction_time,Transaction_amount,Transaction_status,Transaction_type) values(?,?,?,?,?,?,?,?,?);");   
                			   pst.setInt(1, u_receiver.getId());
                			   pst.setString(2,sender_upi_id);
                			   pst.setString(3, user_bank_sender.getBank_name());
                			   pst.setString(4,Receiver_upi_id);
                			   pst.setString(5, user_bank_receiver.getBank_name());
                			   pst.setTimestamp(6, d);
                			   pst.setDouble(7, amount);
                			   pst.setString(8, "Success");
                			   pst.setString(9, "credit");
                			   int row3=pst.executeUpdate();
                			   if(row==1 && row3==1) {
                			   return "Transaction success";
                			   }
                			   else {
                				   pst=conn.prepareStatement("insert into upi_transaction(user_id,sender_upi_id,sender_bank_name,receiver_upi_id,receiver_bank_name,Transaction Time,Transaction_amount,Transaction_status,Transaction_type) values(?,?,?,?,?,?,?,?,?)");   
                    			   pst.setInt(1, u_sender.getId());
                    			   pst.setString(2,sender_upi_id);
                    			   pst.setString(3, user_bank_sender.getBank_name());
                    			   pst.setString(4,Receiver_upi_id);
                    			   pst.setString(5, user_bank_receiver.getBank_name());
                    			   pst.setTimestamp(6, d);
                    			   pst.setDouble(7, amount);
                    			   pst.setString(8, "Failure");
                    			   pst.setString(9, "failed");
                    			   row=pst.executeUpdate();
                				   return "Transaction failure"; 
                			   }
                			   }
                		   else {
                			   return "Transaction failure"; 
                		   }
                	   }
                	  }
                	  }
            	  
            	  
              }
              catch (Exception e) {
            	  e.printStackTrace();
				// TODO: handle exception
			}
              return "";
        }
        
        public static List<transaction_model>  transactionhistory(int user_id){
        	     List<transaction_model> list=new ArrayList<transaction_model>();
        	     transaction_model tm=null;
        	     Connection conn=Dbconnection.Connect();
        	     try {
        	    	  PreparedStatement pst=conn.prepareStatement("select * from upi_transaction where user_id=?");
        	    	 pst.setInt(1, user_id);
        	    	 ResultSet rst=pst.executeQuery();
        	    	 while(rst.next()) {
        	    	    tm=new transaction_model();
        	    	    tm.setSender_upi_id(rst.getString("sender_upi_id"));
        	    	    tm.setReceiver_upi_id(rst.getString("receiver_upi_id"));
        	    	    tm.setTransaction_time(rst.getTimestamp("transaction_time"));
        	    	    tm.setTransaction_amount(rst.getDouble("transaction_amount"));
        	    	    tm.setTransaction_status(rst.getString("transaction_status"));
        	    	    tm.setTransaction_type(rst.getString("transaction_type"));
        	    	    
        	    	    pst=conn.prepareStatement("select * from user_upi_id_details where upi_id=?");
        	    	    pst.setString(1, tm.getReceiver_upi_id());
        	    	    ResultSet rst1=pst.executeQuery();
        	    	    boolean b=rst1.next();
        	    	    
        	    	    if(b==true) {
        	    	    	tm.setReceiver_user_id(rst1.getInt("user_id"));        	    	    	
        	    	    }
        	    	    pst=conn.prepareStatement("select * from user_upi_id_details where upi_id=?");
        	    	    pst.setString(1, tm.getSender_upi_id());
        	    	    ResultSet rst3=pst.executeQuery();
        	    	    boolean b2=rst3.next();
        	    	    
        	    	    if(b2==true) {
        	    	    	tm.setSender_user_id(rst3.getInt("user_id"));        	    	    	
        	    	    }
        	    	    
        	    	    pst=conn.prepareStatement("select * from upiuser where id=?");
        	    	    pst.setInt(1, tm.getReceiver_user_id());
        	    	    ResultSet rst2=pst.executeQuery();
        	    	    boolean bb=rst2.next();
        	    	    if(bb==true) {
        	    	    	tm.setReceiver_name(rst2.getString("name"));
        	    	    }
        	    	    pst=conn.prepareStatement("select * from upiuser where id=?");
        	    	    pst.setInt(1, tm.getSender_user_id());
        	    	    ResultSet rst4=pst.executeQuery();
        	    	    boolean bb2=rst4.next();
        	    	    if(bb2==true) {
        	    	    	tm.setSender_name(rst4.getString("name"));
        	    	    }
        	    	   
        	    	    list.add(tm);
        	    	     //list.reversed();
        	    	 }
        	    	 list=list.reversed();
        	    	 System.out.println(list);
        	    	return list;
        	     }
        	     catch (Exception e) {
					e.printStackTrace();
				}
        	     return null;
        }
}
