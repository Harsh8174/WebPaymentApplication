package Model;

public class User {
private int id;	
private String username;
private long contact;
private String email;
private String gender;
private String Password;
private boolean upi_id_created;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public long getContact() {
	return contact;
}
public void setContact(long contact) {
	this.contact = contact;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getGender() {
	return gender;
}
public void setGender(String gender) {
	this.gender = gender;
}
public String getPassword() {
	return Password;
}
public void setPassword(String password) {
	Password = password;
}
@Override
public String toString() {
	return "User [id=" + id + ", username=" + username + ", contact=" + contact + ", email=" + email + ", gender="
			+ gender + ", Password=" + Password + "]";
}
public boolean isUpi_id_created() {
	return upi_id_created;
}
public void setUpi_id_created(boolean upi_id_created) {
	this.upi_id_created = upi_id_created;
}

}
