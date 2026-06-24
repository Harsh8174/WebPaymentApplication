package Model;

import java.sql.Timestamp;

public class transaction_model {
	 private int sender_user_id;
	 private String sender_upi_id;
	 private String sender_name;
	 private int receiver_user_id;
     private String receiver_upi_id;
     private String receiver_name;
     private Timestamp transaction_time;
     private double transaction_amount;
     private String transaction_status;
     private String transaction_type;
	 public String getSender_upi_id() {
		 return sender_upi_id;
	 }
	 public void setSender_upi_id(String sender_upi_id) {
		 this.sender_upi_id = sender_upi_id;
	 }
	 public String getSender_name() {
		 return sender_name;
	 }
	 public void setSender_name(String sender_name) {
		 this.sender_name = sender_name;
	 }
	 public String getReceiver_upi_id() {
		 return receiver_upi_id;
	 }
	 public void setReceiver_upi_id(String receiver_upi_id) {
		 this.receiver_upi_id = receiver_upi_id;
	 }
	 public String getReceiver_name() {
		 return receiver_name;
	 }
	 public void setReceiver_name(String receiver_name) {
		 this.receiver_name = receiver_name;
	 }
	 public Timestamp getTransaction_time() {
		 return transaction_time;
	 }
	 public void setTransaction_time(Timestamp transaction_time) {
		 this.transaction_time = transaction_time;
	 }
	 public double getTransaction_amount() {
		 return transaction_amount;
	 }
	 public void setTransaction_amount(double transaction_amount) {
		 this.transaction_amount = transaction_amount;
	 }
	 public String getTransaction_status() {
		 return transaction_status;
	 }
	 public void setTransaction_status(String transaction_status) {
		 this.transaction_status = transaction_status;
	 }
	 public String getTransaction_type() {
		 return transaction_type;
	 }
	 public void setTransaction_type(String transaction_type) {
		 this.transaction_type = transaction_type;
	 }
	 public int getReceiver_user_id() {
		 return receiver_user_id;
	 }
	 public void setReceiver_user_id(int receiver_user_id) {
		 this.receiver_user_id = receiver_user_id;
	 }
	 public int getSender_user_id() {
		 return sender_user_id;
	 }
	 public void setSender_user_id(int sender_user_id) {
		 this.sender_user_id = sender_user_id;
	 }
     
}
