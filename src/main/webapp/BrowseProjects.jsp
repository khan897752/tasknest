<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || role == null || !"freelancer".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    List<Map<String, String>> projects = UserDBlogic.getAllProjects();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Projects | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/browse.css">
    <style type="text/css">
        .save-btn {
    background-color: #ffffff;
    color: #333;
    border: 1px solid #ccc;
    padding: 6px 14px;
    font-family: 'Poppins', sans-serif;
    font-size: 14px;
    border-radius: 6px;
    cursor: pointer;
    margin-top: 8px;
    transition: all 0.3s ease;
}

.save-btn:hover {
    background-color: #f2f2f2;
    border-color: #999;
}
    </style>
</head>
<body>
    <!-- 🔝 Navbar -->
   <nav class="navbar">
    <div class="logo">TaskNest</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="freelancerDashboard.jsp">Dashboard</a>
        <a href="about.jsp">About</a>
        <a href="MyProfile.jsp">Profile</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</nav>

    <!-- 📋 Project List -->
    <section class="dashboard">
        <h2>Available Projects</h2>

        <div class="card-grid">
            <%
                if (projects.isEmpty()) {
            %>
                <div class="card">
                    <p>No projects available at the moment. Check back soon!</p>
                </div>
            <%
                } else {
                    for (Map<String, String> project : projects) {
            %>
                <div class="card">
                    <h3><%= project.get("title") %></h3>
                    <p><strong>Category:</strong> <%= project.get("category") %></p>
                    <p><strong>Budget:</strong> ₹<%= project.get("budget") %></p>
                    <p><strong>Deadline:</strong> <%= project.get("deadline") %></p>
                    <p><strong>Posted:</strong> <%= project.get("posted_at") %></p>
                    <p><%= project.get("description") %></p>
                    <a href="ApplyProject.jsp?id=<%= project.get("id") %>" class="apply-btn">Apply</a>
                    <form action="SaveProjectServlet" method="post" style="margin-top: 8px;">
                            <input type="hidden" name="freelancer_name" value="<%= fullname %>">
                            <input type="hidden" name="project_id" value="<%= project.get("id") %>">
                            <button type="submit" class="save-btn">💾 Save</button>
                    </form>
                    
                    <form action="UnsaveProjectServlet" method="post">
                             <input type="hidden" name="freelancer_name" value="<%= fullname %>">
                             <input type="hidden" name="project_id" value="<%= project.get("id") %>">
                             <button type="submit" class="save-btn">❌ Unsave</button>
                    </form>
                    
                </div>
            <%
                    }
                }
            %>
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