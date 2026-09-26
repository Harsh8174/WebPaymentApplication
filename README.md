# Web Payment Application

A web-based **Payment Management Application** developed using Java web technologies. The application provides a platform for users to manage payment-related activities through a web interface.

The project demonstrates the practical implementation of **Java Servlets, JSP, JDBC, MySQL, HTML, CSS, and JavaScript** using a layered web application structure.

## 📌 Project Overview

The **Web Payment Application** is designed to provide users with a simple web-based interface for performing and managing payment-related operations.

The application provides functionality for:

* User registration and login
* User authentication
* Managing user information
* Payment-related operations
* Storing transaction information
* Retrieving payment records from the database
* Displaying payment information through JSP pages

The project was developed to understand how a complete Java-based web application communicates with a relational database.

## 🚀 Features

### User Module

* User registration
* User login
* User authentication
* User profile management
* Session management
* Logout functionality

### Payment Module

* Initiate payment
* Enter payment details
* Process payment requests
* Store payment information
* Retrieve payment records
* Display payment status
* View transaction details

### Database Management

The application uses **JDBC** to communicate with the MySQL database.

The application performs operations such as:

* Insert
* Select
* Update
* Delete

for managing users and payment-related information.

## 🛠️ Technologies Used

| Technology    | Purpose                                |
| ------------- | -------------------------------------- |
| Java          | Backend programming                    |
| JSP           | Dynamic web pages                      |
| Servlet       | Request processing and business logic  |
| JDBC          | Database connectivity                  |
| MySQL         | Database                               |
| HTML          | Web page structure                     |
| CSS           | UI styling                             |
| JavaScript    | Client-side validation and interaction |
| Apache Tomcat | Web server / Servlet container         |
| Eclipse       | Development environment                |

## 🏗️ Architecture

The application follows a Java web MVC-style architecture.

```text
                    ┌─────────────────────┐
                    │       Browser       │
                    │   HTML / CSS / JS   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │        JSP          │
                    │    Presentation     │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │      Servlet        │
                    │  Request Handling   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    Java Classes     │
                    │   Business Logic    │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │        JDBC         │
                    │ Database Connectivity│
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │       MySQL         │
                    │      Database       │
                    └─────────────────────┘
```

## 📂 Project Structure

```text
Payflowmoney
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── bankdeatilsinsertion/
│   │   │   │   └── bankdetails.java
│   │   │   ├── Controller/
│   │   │   │   ├── Ajaxservlet.java
│   │   │   │   ├── dashboardpageloadercontroller.java
│   │   │   │   ├── fileuploadcontroller.java
│   │   │   │   ├── Transactioncontoller.java
│   │   │   │   ├── Upi_id_Creator.java
│   │   │   │   ├── Usercontroller.java
│   │   │   │   ├── UserUpicontroller.java
│   │   │   │   └── code.txt
│   │   │   ├── DAO/
│   │   │   │   ├── bankdetails_dao.java
│   │   │   │   ├── Dao.java
│   │   │   │   ├── DaoTransaction.java
│   │   │   │   └── UserBankDao.java
│   │   │   ├── DBCONNECTION/
│   │   │   │   └── Dbconnection.java
│   │   │   ├── Emailservice/
│   │   │   │   └── EmailService.java
│   │   │   └── Model/
│   │   │       ├── transaction_model.java
│   │   │       ├── User_Bankdetails.java
│   │   │       ├── User_Upi.java
│   │   │       ├── User.java
│   │   │       └── Emailrelateddetails.txt
│   │   └── webapp/
│   │       ├── HTML/
│   │       │   ├── Bankvalidationform.html
│   │       │   ├── dashboard.css
│   │       │   ├── dashboard.html
│   │       │   ├── Forgotpassword.html
│   │       │   ├── GenerateOtp.html
│   │       │   ├── Index.html
│   │       │   ├── Login.html
│   │       │   ├── Navigation.html
│   │       │   ├── Reg_regenerateotp.css
│   │       │   ├── Registration.html
│   │       │   ├── RegOtpGenerator.html
│   │       │   ├── ResetPassword.html
│   │       │   ├── script.js
│   │       │   ├── scriptsuccess.js
│   │       │   ├── sendMoney.html
│   │       │   ├── Setpin.html
│   │       │   ├── success.css
│   │       │   ├── Success.html
│   │       │   ├── UPIAccountcreation.css
│   │       │   ├── upisetup.html
│   │       │   ├── Welcome.html
│   │       │   └── welcome.js
│   │       ├── images/
│   │       ├── META-INF/
│   │       └── WEB-INF/
│   │           ├── Account_Creation_Successful.jsp
│   │           ├── Bankvalidation.jsp
│   │           ├── dashboard.jsp
│   │           ├── Enterbankdetails.html
│   │           ├── first request execution flow.png
│   │           ├── ForgotPassword.jsp
│   │           ├── index.jsp
│   │           ├── Login.jsp
│   │           ├── note.txt
│   │           ├── receive.jsp
│   │           ├── Register.jsp
│   │           ├── Reg-Otp-Verification.jsp
│   │           ├── ResetPassword.jsp
│   │           ├── sendMoney.jsp
│   │           ├── transactions.jsp
│   │           └── UPIAccountcreation.jsp
├── Libraries/
│   ├── JRE System Library [JavaSE-21]
│   ├── Referenced Libraries
│   ├── Server Runtime [Apache Tomcat v9.0]
│   └── Web App Libraries
└── Referenced Libraries/
    └── mysql-connector-j-9.7.0.jar
```

## 🗄️ Database

The application uses **MySQL** for persistent storage.

The database stores information related to:

* Users
* Payment details
* Transactions
* Payment status
* Other application-related information

A simplified payment record can contain information such as:

```text
Transaction ID
User ID
Amount
Payment Method
Transaction Date
Payment Status
```

## 🔄 Application Flow

The basic application flow is:

```text
User
  ↓
Open Web Application
  ↓
Register / Login
  ↓
User Authentication
  ↓
User Dashboard
  ↓
Enter Payment Details
  ↓
Payment Request
  ↓
Servlet Processes Request
  ↓
JDBC
  ↓
MySQL Database
  ↓
Payment Result
  ↓
JSP Displays Result
```

## 🔐 Authentication Flow

The application uses session-based authentication.

```text
User Login
    ↓
Login Servlet
    ↓
Validate Credentials
    ↓
Check User in Database
    ↓
Credentials Valid?
   / \
 Yes  No
  ↓    ↓
Create  Show
Session Error
  ↓
Dashboard
```

After successful authentication, the user's information can be maintained using an HTTP session.

## 💳 Payment Processing Flow

A typical payment operation follows this flow:

```text
User enters payment details
            ↓
       Submit Form
            ↓
      Payment Servlet
            ↓
     Validate Input
            ↓
      JDBC Connection
            ↓
      Execute SQL Query
            ↓
     Store Transaction
            ↓
      Get Payment Result
            ↓
       JSP Response
            ↓
   Display Payment Status
```

## 🧩 Backend Components

### JSP

JSP is used for the presentation layer.

It is responsible for:

* Displaying forms
* Displaying user information
* Displaying payment information
* Displaying success/error messages
* Sending user input to Servlets

### Servlet

Servlets act as the controller layer.

They are responsible for:

* Receiving HTTP requests
* Reading form parameters
* Validating input
* Calling backend logic
* Communicating with JDBC
* Managing sessions
* Redirecting/forwarding requests

### JDBC

JDBC provides connectivity between the Java application and MySQL.

Typical flow:

```text
Java Application
      ↓
JDBC Driver
      ↓
Connection
      ↓
PreparedStatement
      ↓
SQL Query
      ↓
MySQL
```

`PreparedStatement` can be used for executing parameterized SQL queries and reducing SQL injection risks.

## 🖥️ Frontend

The frontend is developed using:

* HTML
* CSS
* JavaScript
* JSP

JavaScript is used for client-side interactions and form validation, while JSP dynamically generates pages based on server-side data.

## ⚙️ Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
```

### 2. Import the Project

Import the project into:

* Eclipse
* Spring Tool Suite
* Any IDE supporting Java web applications

### 3. Configure MySQL

Create the required database in MySQL.

Example:

```sql
CREATE DATABASE Payflowmoney;
```

Create the required tables according to the SQL/database structure used by the project.

### 4. Configure JDBC

Update the database connection details in the application's database configuration/class.

Example:

```java
String url = "jdbc:mysql://localhost:3306/Payflowmoney";
String username = "root";
String password = "YOUR_PASSWORD";
```

Replace the credentials with your local MySQL configuration.

### 5. Configure Apache Tomcat

Deploy the application on **Apache Tomcat**.

Example:

```text
http://localhost:8080/Payflowmoney
```

The port and context path may vary depending on your local configuration.

## ▶️ How to Run

1. Start MySQL.
2. Start Apache Tomcat.
3. Deploy the Payflowmoney application.
4. Open the application in a browser.
5. Register a new user.
6. Login using the registered credentials.
7. Access the payment functionality.
8. Enter the required payment information.
9. Submit the payment request.
10. View the transaction/payment result.

## 📚 Concepts Demonstrated

This project demonstrates practical knowledge of:

* Core Java
* Java Web Development
* Servlets
* JSP
* JDBC
* MySQL
* HTML
* CSS
* JavaScript
* MVC Architecture
* HTTP Request/Response
* Session Management
* CRUD Operations
* SQL Queries
* PreparedStatement
* Form Handling
* Server-side Validation
* Client-side Validation
* Exception Handling
* Apache Tomcat
* Git/GitHub

## 🔮 Future Enhancements

Possible improvements include:

* Spring Boot migration
* Spring Security integration
* REST API development
* JWT authentication
* Integration with a real payment gateway
* Transaction history
* Email notifications
* Payment receipt generation
* Admin dashboard
* Advanced transaction search
* Pagination
* Improved security
* Cloud deployment
* Dockerization

## 🎯 Project Objective

The main objective of this project was to build a complete **Java-based web application** and gain practical experience in developing a database-driven application using **JSP, Servlets, JDBC, and MySQL**.

The project helped demonstrate how a user's request travels from the frontend through a Servlet and JDBC layer to the database and how the response is returned to the user through JSP.

## 👨‍💻 Author

**Harsh Sharma**

B.Tech Computer Science & Engineering

### Skills Demonstrated

```text
Java
JSP
Servlet
JDBC
MySQL
HTML
CSS
JavaScript
Apache Tomcat
Git
GitHub
```

## 📄 License

This project is developed for educational and portfolio purposes.
