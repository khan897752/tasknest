<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tasknest.model.AccountUser" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || !"freelancer".equals(role)) {
        response.sendRedirect("login.jsp?error=session_expired");
        return;
    }

    Map<String, String> profile = UserDBlogic.getFreelancerProfile(fullname);
    List<Map<String, String>> assignedProjects = UserDBlogic.getSavedProjects(fullname);
%>

<!DOCTYPE html>
<html>
<head>
    <title>TaskNest Dashboard</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        .dashboard-menu a {
            display: block;
            padding: 8px;
            text-decoration: none;
            color: #333;
        }
        .dashboard-menu a:hover {
            background-color: #f0f0f0;
        }
        .alert-card {
            background-color: #fff3cd;
            border: 1px solid #ffeeba;
            padding: 15px;
            margin: 20px 30px;
            border-radius: 6px;
            color: #856404;
            font-weight: 500;
        }
        .alert-card a {
            color: #0c5460;
            text-decoration: underline;
        }
        .submit-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 15px;
            margin: 20px;
            color: #fff;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .submit-card h4 {
            margin-bottom: 10px;
        }
        .submit-card p {
            margin-bottom: 15px;
        }
        .submit-card form button {
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            background: #fff;
            color: #9b5de5;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .submit-card form button:hover {
            background: #ffd6e0;
            color: #000;
        }
    </style>
</head>
<body>

<!-- 🔝 Navbar -->
<nav class="navbar">
    <div class="logo">TaskNest</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About</a>
        <a href="MyProfile.jsp">Profile</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</nav>

<!-- 🌄 Hero Section -->
<section class="hero">
    <div class="hero-content">
        <div class="hero-left">
            <h1>Welcome to TaskNest</h1>
            <p>TaskNest is your all-in-one freelance hub — post projects, discover talent, manage workflows, and grow your network.</p>
            <p>Browse exciting freelance projects, apply with confidence, and grow your career with TaskNest.</p>

            <div class="hero-buttons">
                <a href="BrowseProjects.jsp" class="btn primary">Explore Projects</a>
                <a href="MyApplications.jsp" class="btn alt">My Applications</a>
            </div>
        </div>
        <div class="hero-right">
            <img src="images/tasknest-hero.jpg" alt="Freelance illustration">
        </div>
    </div>
</section>

<!-- 📦 Dashboard Section -->
<section class="dashboard">
    <h2>Hello, <%= fullname %>!</h2>

    <%-- ✅ Show alert if profile is missing --%>
    <% if (profile.get("email") == null) { %>
        <div class="alert-card">
            <p>🚀 You haven’t created your profile yet. <a href="EditProfile.jsp">Click here to get started</a>.</p>
        </div>
    <% } %>

    <div class="card-grid">
        <a href="BrowseProjects.jsp" class="card">🔍 Browse Projects</a>
        <a href="MyApplications.jsp" class="card">📄 My Applications</a>

        <% if (profile.get("email") == null) { %>
            <a href="EditProfile.jsp" class="card">🛠️ Create Profile</a>
        <% } else { %>
            <a href="EditProfile.jsp" class="card">🛠️ Edit Profile</a>
        <% } %>

        <a href="MyProfile.jsp" class="card">👤 My Profile</a>
        <a href="SavedProjects.jsp" class="card">💼 Saved Projects</a>
        <a href="Messages.jsp" class="card">💬 Messages</a>
    </div>
</section>

<!-- 📤 Submit Work Section -->
<section class="dashboard">
    <h3 style="margin-left: 30px;">📤 Submit Work for Assigned Projects</h3>
    <% if (assignedProjects != null && !assignedProjects.isEmpty()) { %>
        <% for (Map<String, String> project : assignedProjects) { %>
            <div class="submit-card">
                <h4><%= project.get("title") %></h4>
                <p><%= project.get("description") %></p>
                <form action="submitDelivery.jsp" method="get">
                    <input type="hidden" name="projectId" value="<%= project.get("id") %>">
                    <input type="hidden" name="freelancerId" value="<%= session.getAttribute("freelancerId") %>">
                    <button type="submit">Submit Work</button>
                </form>
            </div>
        <% } %>
    <% } else { %>
        <div class="alert-card">
            <p>No assigned projects yet. Once a client assigns you a project, it will appear here.</p>
        </div>
    <% } %>
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