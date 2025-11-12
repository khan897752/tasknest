<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login | TaskNest</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/login.css">
  <link rel="stylesheet" href="css/responsive.css">
  <style>
  select[name="role"] {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    border-radius: 8px;
    border: none;
    font-family: 'Poppins', sans-serif;
    font-size: 16px;
    background: #fff;
    color: #333;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    appearance: none;
    transition: box-shadow 0.3s ease;
  }

  select[name="role"]:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(252, 191, 73, 0.5);
  }
</style>
</head>
<body class="gradient-bg">
  <div class="navbar">
    <div class="logo">TaskNest</div>
    <nav>
      <a href="index.jsp">Home</a>
      <a href="Contactme.jsp">Contact</a>
      <a href="about.jsp">About</a>
    </nav>
    <div class="nav-buttons">
      <a href="signupClient.jsp" class="btn">Sign Up</a>
    </div>
  </div>

  <section class="login-wrapper">
    <div class="login-box">
    <% String fullname=request.getParameter("fullname"); 
       if(fullname==null){
    	   fullname="Back";
       }
    %>
      <h2>Welcome <%=fullname%></h2>
      <p>Log in to your TaskNest account</p>
      <form action="LoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <!-- 🔹 Role Selection Dropdown -->
        <select name="role" required>
          <option value="">Select Role</option>
          <option value="client">Client</option>
          <option value="freelancer">Freelancer</option>
        </select>

        <button type="submit" class="btn primary">Login</button>
      </form>

      <p class="signup-link">Don't have an account?
        <a href="signupClient.jsp">Sign up as Client</a> or
        <a href="signupFreelancer.jsp">Freelancer</a>
      </p>
    </div>
  </section>

  <footer>
    <div class="footer-links">
      <a href="privacy.jsp">Privacy</a>
      <a href="terms.jsp">Terms</a>
    </div>
  </footer>
</body>
</html>