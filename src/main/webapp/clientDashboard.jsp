<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tasknest.model.AccountUser" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || role == null) {
        response.sendRedirect("login.jsp?error=session_expired");
        return;
    }
%>
<%
    List<Map<String, String>> projects = UserDBlogic.getProjectsByClient(fullname);
%>
<!DOCTYPE html>
<html>
<head>
    <title>TaskNest Dashboard</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <!-- 🔝 Navbar -->
    <nav class="navbar">
        <div class="logo">TaskNest</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="Contactme.jsp">Contact</a>
            <a href="about.jsp">About</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

<!-- 🌄 Redesigned Hero Section -->
<section class="hero">
  <div class="hero-content">
    <div class="hero-left">
      <h1>Welcome to TaskNest</h1>
      <p>TaskNest is your all-in-one freelance hub — post projects, discover talent, manage workflows, and grow your network.</p>
      <% if ("client".equals(role)) { %>
        <p>Post your project, manage applications, and find top freelancers to bring your ideas to life.</p>
      <% } else { %>
        <p>Browse exciting freelance projects, apply with confidence, and grow your career with TaskNest.</p>
      <% } %>

      <div class="hero-buttons">
        <% if ("client".equals(role)) { %>
          <a href="PostProject.jsp" class="btn primary">Post a Project</a>
          <a href="ManageProjects.jsp" class="btn alt">Manage Projects</a>
        <% } else if ("freelancer".equals(role)) { %>
          <a href="BrowseProjects.jsp" class="btn primary">Explore Projects</a>
          <a href="MyApplications.jsp" class="btn alt">My Applications</a>
        <% } %>
      </div>
    </div>

    <div class="hero-right">
      <img src="images/tasknest-hero.jpg" alt="Freelance illustration">
    </div>
  </div>
</section>

    <!-- 📦 Dashboard Cards -->
    <section class="dashboard">
        <h2>Hello, <%= fullname %>!</h2>
        <div class="card-grid">
            <% if ("client".equals(role)) { %>
                <a href="PostProject.jsp" class="card">📝 Post a New Project</a>
                <% for (Map<String, String> project : projects) { %>
                 <a href="ViewApplications.jsp?id=<%= project.get("id") %>" class="card">
                         📄 View Applicationsfor "<%= project.get("title") %>"
                         
                 </a>
                 <% } %>
                <a href="ManageProjects.jsp" class="card">🛠️ Manage Projects</a>
                <a href="Analytics.jsp" class="card">📊 Project Analytics</a>
                <a href="Messages.jsp" class="card">💬 Message Freelancers</a>
            <% } else { %>
                <a href="BrowseProjects.jsp" class="card">🔍 Browse Projects</a>
                <a href="MyApplications.jsp" class="card">📄 My Applications</a>
                <a href="Profile.jsp" class="card">👤 My Profile</a>
                <a href="SavedProjects.jsp" class="card">💼 Saved Projects</a>
                <a href="Messages.jsp" class="card">💬 Messages</a>
            <% } %>
        </div>
    </section>

    <!-- 🔻 Footer -->
    <footer class="footer">
        <p>© 2025 TaskNest. Built with passion by Pathan.</p>
        <div class="footer-links">
            <a href="about.jsp">About</a>
            <a href="terms.jsp">Terms</a>
            <a href="privacy.jsp">Privacy</a>
            <a href="mailto:support@tasknest.com">Contact</a>
        </div>
    </footer>
</body>
</html>