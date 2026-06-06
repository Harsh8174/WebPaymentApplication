package Model;

public class User_Upi {
 private String upi_id;
 private int transaction_limit;
 private String email;
 private String upi_pin;
 private String card_digit; 
 private String expiry_date;
 public String getUpi_id() {
	return upi_id;
 }
 public void setUpi_id(String upi_id) {
	this.upi_id = upi_id;
 }
 public int getTransaction_limit() {
	return transaction_limit;
 }
 public void setTransaction_limit(int transaction_limit) {
	this.transaction_limit = transaction_limit;
 }
 public String getEmail() {
	return email;
 }
 public void setEmail(String email) {
	this.email = email;
 }
 public String getUpi_pin() {
	return upi_pin;
 }
 public void setUpi_pin(String upi_pin) {
	this.upi_pin = upi_pin;
 }
 public String getCard_digit() {
	return card_digit;
 }
 public void setCard_digit(String card_digit) {
	this.card_digit = card_digit;
 }
 public String getExpiry_date() {
	return expiry_date;
 }
 public void setExpiry_date(String expiry_date) {
	this.expiry_date = expiry_date;
 }
}
