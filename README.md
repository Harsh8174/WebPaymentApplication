# B2B Ceramic Portal

A web-based **B2B Ceramic Tiles Portal** designed to connect ceramic tile sellers/manufacturers with business buyers such as tile shops, distributors, and retailers.

The portal allows sellers to manage their products and buyers to browse products, view product details, and interact with sellers through a centralized platform.

## 📌 Project Overview

The **B2B Ceramic Portal** provides a digital platform for the ceramic tile business where:

* Sellers can register and manage their business profile.
* Sellers can upload and manage ceramic tile products.
* Buyers can register and maintain their company details.
* Buyers can browse available ceramic products.
* Products can be filtered based on different attributes.
* Product information such as size, material, finish, price, and quantity is displayed to buyers.
* The system maintains buyer, seller, and product information in a MySQL database.

The project demonstrates the implementation of **Java Web Development, Spring MVC, Hibernate/JPA, JSP, and MySQL**.

## 🚀 Features

### Buyer Module

* Buyer registration and login
* Buyer profile management
* Company information management
* Browse ceramic tile products
* Search and filter products
* View product details
* View seller/product information

### Seller Module

* Seller registration and login
* Seller profile management
* Add new products
* Update product information
* Delete products
* Manage uploaded product images
* View seller's products
* Product categorization based on seller type

### Product Management

The portal supports different types of ceramic products such as:

* Glazed Vitrified Tiles (GVT)
* Vitrified Tiles
* Porcelain Tiles
* Wall Tiles
* Floor Tiles
* Parking Tiles
* Slabs
* Step & Riser

Product information can include:

* Product name
* Category
* Material
* Size
* Thickness
* Finish
* Price
* Quantity per box
* Product images
* Seller/company information

## 🛠️ Technologies Used

| Technology                  | Purpose                    |
| --------------------------- | -------------------------- |
| Java                        | Backend programming        |
| JSP                         | Frontend/server-side views |
| HTML                        | Web page structure         |
| CSS                         | Styling                    |
| JavaScript                  | Client-side functionality  |
| Spring MVC                  | Web application framework  |
| Hibernate                   | ORM / Database interaction |
| JPA                         | Persistence API            |
| MySQL                       | Database                   |
| Maven                       | Dependency management      |
| Apache Tomcat               | Application server         |
| Eclipse / Spring Tool Suite | Development environment    |

## 🏗️ Architecture

The project follows a layered MVC-based architecture:

```text
                 ┌─────────────────────┐
                 │       Browser       │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │      JSP / UI       │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │   Spring MVC        │
                 │   Controllers       │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │   Service Layer     │
                 │ Business Logic      │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │ DAO / Repository    │
                 │ Layer               │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │ Hibernate / JPA     │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │       MySQL         │
                 └─────────────────────┘
```

## 📂 Project Structure

```text
Ceramic_B2B_Project
│
├── src
│   └── main
│       ├── java
│       │   └── com
│       │       └── ...
│       │
│       ├── resources
│       │   └── ...
│       │
│       └── webapp
│           │
│           ├── WEB-INF
│           │   ├── Buyer
│           │   ├── Seller
│           │   └── ...
│           │
│           └── ...
│
├── pom.xml
└── README.md
```

## 🗄️ Database

The application uses **MySQL** as its relational database.

The database stores information related to:

* Buyers
* Sellers
* Companies
* Products
* Product categories
* Product images
* User authentication
* Other application-related data

### Example Product Information

```text
Product Name : Royal Grey Marble
Category     : Floor
Material     : Vitrified
Size         : 600 X 1200 mm
Thickness    : 9 mm
Finish       : Glossy
Price        : ₹350
Quantity     : 48 pcs/box
```

## 🔐 Authentication

The portal provides separate authentication flows for:

### Buyer

```text
Buyer Registration
        ↓
Buyer Login
        ↓
Buyer Dashboard
        ↓
Browse Products
```

### Seller

```text
Seller Registration
        ↓
Seller Login
        ↓
Seller Dashboard
        ↓
Manage Products
```

Session management is used to maintain logged-in user information during the user's interaction with the application.

## 🖼️ Product Image Management

Sellers can upload multiple images for their products.

The application supports uploading up to **6 product images** for a product.

Uploaded images are stored in the application's dedicated seller upload directory.

```text
WEB-INF/
   └── Seller/
       └── Seller_upload_images/
```

## 🔄 Product Filtering

Buyers can find products using different product attributes, such as:

```text
Category
   ↓
Material
   ↓
Size
   ↓
Finish
   ↓
Other Product Attributes
```

This helps buyers find ceramic products according to their business requirements.

## ⚙️ Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
```

### 2. Import the Project

Open the project in:

* Eclipse
* Spring Tool Suite (STS)

Import it as a **Maven Project**.

### 3. Configure MySQL

Create a MySQL database:

```sql
CREATE DATABASE B2B_Cermaic_Project;
```

Update your database configuration according to your local MySQL setup.

Example:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/B2B_Cermaic_Project
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

> Replace the database username and password with your own local credentials.

### 4. Install Dependencies

Maven will automatically download the dependencies defined in:

```text
pom.xml
```

You can also run:

```bash
mvn clean install
```

### 5. Configure Tomcat

Deploy the project on **Apache Tomcat**.

Example:

```text
http://localhost:8080/Ceramic_B2B_Project
```

The exact port may depend on your Tomcat configuration.

## ▶️ How to Run

1. Start MySQL.
2. Start Apache Tomcat.
3. Open the project URL in a browser.
4. Register as a buyer or seller.
5. Login to the respective dashboard.
6. Sellers can add/manage products.
7. Buyers can browse and filter products.

## 🔑 Main User Roles

### Seller

```text
Register
   ↓
Login
   ↓
Seller Dashboard
   ↓
Add Product
   ↓
Upload Images
   ↓
Manage Products
```

### Buyer

```text
Register
   ↓
Login
   ↓
Buyer Dashboard
   ↓
Browse Products
   ↓
Filter Products
   ↓
View Product Details
```

## 📚 Concepts Demonstrated

This project demonstrates practical implementation of:

* Java
* Object-Oriented Programming
* MVC Architecture
* Spring MVC
* Dependency Injection
* Inversion of Control
* Hibernate ORM
* JPA
* Entity Mapping
* Repository / DAO Pattern
* CRUD Operations
* MySQL Database Integration
* JSP
* Session Management
* Form Handling
* File Upload
* Product Management
* User Authentication
* Database Relationships
* Maven

## 🎯 Project Objective

The main objective of this project is to develop a **B2B digital marketplace for the ceramic tile industry**, providing separate functionality for buyers and sellers while demonstrating enterprise-level Java web development concepts.

## 🔮 Future Enhancements

Possible future improvements include:

* REST API integration
* Spring Boot migration
* Spring Security authentication
* JWT-based authentication
* Online enquiry system
* Buyer-seller messaging
* Product quotation system
* Email notifications
* WhatsApp integration
* Advanced product search
* Pagination
* Cloud image storage
* Online order management
* Payment gateway integration
* Admin dashboard
* Product recommendation system

## 👨‍💻 Author

**Harsh Sharma**

B.Tech Computer Science & Engineering

### Skills Demonstrated

```text
Java
Spring MVC
Hibernate
JPA
JSP
MySQL
HTML
CSS
JavaScript
Maven
Git
```

## 📄 License

This project is developed for educational and portfolio purposes.
