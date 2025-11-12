# 🧱 TaskNest — Freelance Micro-Task Platform 🚀

![TaskNest Demo](tasknest-demo.gif)

TaskNest is a full-stack Java web application built using *Java Servlets, JSP, JDBC, and MySQL*.  
It’s a role-based platform where *Clients* can post projects, *Freelancers* can apply, and *Admins* can manage everything.

---

## 🌟 Features
- 🔐 Role-based login (Client / Freelancer / Admin)
- 💼 Project posting, applications & messaging
- 🧾 Admin dashboard with analytics
- 🎨 Pure HTML, CSS, and JS (no frameworks)
- 🧩 Secure DB connection with config file

---

## ⚙ Tech Stack
Java Servlets | JSP | JDBC | MySQL | HTML | CSS | JavaScript | Apache Tomcat

---

## 🚀 Setup Instructions

1. *Clone this repo*
   ```bash
   git clone https://github.com/khan897752/tasknest.git 
   
🛢️ 2. Import the Database
- Open MySQL Workbench
- Navigate to: Server → Data Import
- Import file: database/tasknest_schema.sql


🛠️ 3. Configure Database Connection
- Copy config_sample.properties → rename to config.properties
- Move it to: WebContent/WEB-INF/classes/
- Add your MySQL credentials:
db.url=jdbc:mysql://localhost:3306/tasknest
db.username=root
db.password=yourpassword


🚀 4. Run the App
- Open the project in Eclipse IDE
- Run on Apache Tomcat v10+
- Visit: http://localhost:8080/TaskNest

💡 Author
Farhad Khan
Full-Stack Java Developer | Learning by Building
🔗 GitHub: https://github.com/khan897752

🏷 Tags
#TaskNest #JavaDeveloper #FullStackDevelopment #JSP #Servlets #JDBC #MySQL #WebDevelopment

💼 Full-stack freelance platform built with Java Servlets, JSP, and MySQL.

   