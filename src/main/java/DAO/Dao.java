package DAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import DBCONNECTION.Dbconnection;
import Model.*;
public class Dao {
	private int setopt;
	public static void createaccount(User u){
		Connection conn= Dbconnection.Connect();
		  try {
			PreparedStatement pst=conn.prepareStatement("insert into upiuser(name,email,contact,gender,password,upi_id_created) values (?,?,?,?,?,?)");
			pst.setString(1,u.getUsername());
			pst.setString(2,u.getEmail() );
			pst.setLong(3,u.getContact());
			pst.setString(4,u.getGender());
			pst.setString(5, u.getPassword());
			u.setUpi_id_created(false);
			pst.setBoolean(6, u.isUpi_id_created());
			pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static boolean checkemail(String email) {
		Connection conn= Dbconnection.Connect();
		boolean flag=true;
		try {
			PreparedStatement pst=conn.prepareStatement("select email from upiuser where email=?");
			pst.setString(1, email);
			ResultSet rst=pst.executeQuery();
			if(rst.next()) {
				
		         flag=false;
		         return flag;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	public static boolean validateemail(String email) {
		Connection conn= Dbconnection.Connect();
		boolean flag=true;
		try {
			PreparedStatement pst=conn.prepareStatement("select email from upiuser where email=?");
			pst.setString(1, email);
			ResultSet rst=pst.executeQuery();
			if(rst.next()) {
				if(rst.getString("email").equalsIgnoreCase(email)) {
		         flag=false;
		         return flag;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	public static boolean validatepassword(String email, String password) {
		Connection conn= Dbconnection.Connect();
		boolean flag=true;
		try {
			PreparedStatement pst=conn.prepareStatement("select password from upiuser where email=?");
			pst.setString(1, email);
			ResultSet rst=pst.executeQuery();
			if(rst.next()) {
				if(rst.getString("password").equalsIgnoreCase(password)) {
		         flag=false;
		         return flag;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	public static User getuser(String email){
		Connection conn= Dbconnection.Connect();
		
		try {
			PreparedStatement pst=conn.prepareStatement("select * from upiuser where email=?");
			pst.setString(1, email);
			ResultSet rst=pst.executeQuery();
			if(rst.next()) {
				User u=new User();
		        u.setId(rst.getInt("id"));
		        u.setUsername(rst.getString("name"));
		        u.setEmail(rst.getString("email"));
		        u.setContact(rst.getLong("contact"));
		        u.setGender(rst.getString("gender"));
		        u.setUpi_id_created(rst.getBoolean("upi_id_created"));
		        return u;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public static boolean Checkupiid(String upi_id) {
Connection conn= Dbconnection.Connect();
		
		try {
			PreparedStatement pst=conn.prepareStatement("select * from user_upi_id_details where upi_id=?");
			pst.setString(1, upi_id);
			ResultSet rst=pst.executeQuery();
			if(rst.next()) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	
	public static String setnewpassword(String email, String new_password){
		
		Connection conn= Dbconnection.Connect();
		try {
			PreparedStatement pst= conn.prepareStatement("update upiuser set password=? where email=?");
		    pst.setString(1, new_password);
		    pst.setString(2, email);
		    pst.executeUpdate();
		    return "Password Updated Succesfully";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

   
public static User_Upi getupiuser(int user_id) {
	User_Upi u=null;
	Connection conn= Dbconnection.Connect();
	try {
		PreparedStatement pst= conn.prepareStatement("select * from user_upi_id_details where user_id=?");
	    pst.setInt(1, user_id);
	    ResultSet rst=  pst.executeQuery();
        
	    if(rst.next()) {
	    	 u=new User_Upi();
        	 u.setUpi_id(rst.getString("upi_id"));
        	 u.setTransaction_limit(rst.getInt("transaction_limit"));
             u.setCard_digit(rst.getString("card_digit"));
             u.setExpiry_date(rst.getString("expiry_date"));
             u.setUpi_pin(rst.getString("upi_pin"));
        	 return u;
         }
	    return u;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return u;
}
public static void setuploadimagename(User u,String file_name,boolean imgstatus) {
	Connection conn= Dbconnection.Connect();
	try {
		PreparedStatement pst=conn.prepareStatement("update upiuser set profile_image_name=?,profile_image_status=? where id=? ");
		pst.setString(1, file_name);
		pst.setBoolean(2, imgstatus);
		pst.setInt(3, u.getId());
	    pst.executeUpdate();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
}
public static  boolean uploadimgstatus(User u) {
	Connection conn= Dbconnection.Connect();
	boolean status=false;
	try {
		PreparedStatement pst=conn.prepareStatement("select * from upiuser where id=? ");
		pst.setInt(1, u.getId());
	    ResultSet rst=  pst.executeQuery();
	   if(rst.next()) { 
		   status=rst.getBoolean("profile_image_status");  
	   }
	
	}
	catch (Exception e) {
		e.printStackTrace();
	}      
	   return status;
}
public static String getimgfilename(User u) {
	Connection conn= Dbconnection.Connect();

	String File_name="";
	try {
		PreparedStatement pst=conn.prepareStatement("select * from upiuser where id=? ");
		pst.setInt(1, u.getId());
	    ResultSet rst=  pst.executeQuery();
	   if(rst.next()) { 
		   File_name=rst.getString("profile_image_name"); 
	   }
	
	}
	catch (Exception e) {
		e.printStackTrace();
	}      
	   return File_name;
}
}