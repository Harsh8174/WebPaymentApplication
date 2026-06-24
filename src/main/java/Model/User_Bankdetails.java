package Model;

public class User_Bankdetails {	
private int user_id;
private String name;
private String bank_name;
private long account_number;
private String ifsc;
private String account_type;
private String mobile_number;
private double bankbalance;
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getBank_name() {
	return bank_name;
}
public void setBank_name(String bank_name) {
	this.bank_name = bank_name;
}
public long getAccount_number() {
	return account_number;
}
public void setAccount_number(long account_number) {
	this.account_number = account_number;
}
public String getIfsc() {
	return ifsc;
}
public void setIfsc(String ifsc) {
	this.ifsc = ifsc;
}
public String getAccount_type() {
	return account_type;
}
public void setAccount_type(String account_type) {
	this.account_type = account_type;
}
public String getMobile_number() {
	return mobile_number;
}
public void setMobile_number(String mobile_number) {
	this.mobile_number = mobile_number;
}

@Override
public String toString() {
	return "User_Bankdetails [name=" + name + ", bank_name=" + bank_name + ", account_number=" + account_number
			+ ", ifsc=" + ifsc + ", account_type=" + account_type + ", mobile_number=" + mobile_number + "]";
}
public double getBankbalance() {
	return bankbalance;
}
public void setBankbalance(double bankbalance) {
	this.bankbalance = bankbalance;
}
public int getUser_id() {
	return user_id;
}
public void setUser_id(int user_id) {
	this.user_id = user_id;
}
}
