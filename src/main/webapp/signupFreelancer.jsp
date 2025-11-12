<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Freelancer Sign-Up | TaskNest</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/signupFreelancer.css">
  <link rel="stylesheet" href="css/responsive.css">
</head>
<body>
  <div class="signup-wrapper">
    
    <!-- 🎯 Left Hero Section -->
    <div class="signup-hero">
      <h1>Welcome, Freelancer!</h1>
      <p>Find work, showcase your skills, and grow your career with TaskNest.</p>
      <img src="images/freelancer-hero.jpg" alt="Freelancer Illustration">
    </div>

    <!-- 📝 Right Form Section -->
    <div class="signup-form-section">
      <div class="role-badge">You're signing up as a <strong>Freelancer</strong></div>
      <form action="FreelancerSignupServlet" method="post" class="signup-form">
        <input type="text" name="fullname" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
        <input type="text" name="skills" placeholder="Skills (e.g., Java, Design)" required>
        <button type="submit" class="btn">Sign Up</button>
      </form>
      <p class="login-link">Already have an account? <a href="login.jsp">Login here</a></p>
    </div>

  </div>
</body>
</html>