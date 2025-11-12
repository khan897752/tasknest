<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Choose Your Role | TaskNest</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/role.css">
  <link rel="stylesheet" href="css/responsive.css">
</head>
<body>
  <div class="role-container">
    <h2>Choose Your Role</h2>
    <p>Are you signing up as a Client or Freelancer?</p>
    <div class="role-cards">
      <div class="role-card client" onclick="location.href='signupClient.jsp'">
        <img src="images/client-icon.jpg" alt="Client Icon">
        <h3>I'm a Client</h3>
        <p>Post jobs and hire top freelancers.</p>
      </div>
      <div class="role-card freelancer" onclick="location.href='signupFreelancer.jsp'">
        <img src="images/freelancer-icon.jpg" alt="Freelancer Icon">
        <h3>I'm a Freelancer</h3>
        <p>Find work and grow your career.</p>
      </div>
    </div>
  </div>
</body>
</html>