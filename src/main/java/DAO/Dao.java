package DAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBCONNECTION.Dbconnection;
import Model.*;
public class Dao {
	
	public static void createaccount(User u){
		Connection conn= Dbconnection.Connect();
		  try {
			PreparedStatement pst=conn.prepareStatement("insert into upiuser(name,email,contact,gender) values (?,?,?,?)");
			pst.setString(1,u.getUsername());
			pst.setString(2,u.getEmail() );
			pst.setLong(3,u.getContact());
			pst.setString(4,u.getGender());
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
}
