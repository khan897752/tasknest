<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || role == null || !"freelancer".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    List<Map<String, String>> savedProjects = UserDBlogic.getSavedProjects(fullname);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Saved Projects | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/browse.css">
</head>
<body>
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

    <section class="dashboard">
        <h2>🔖 Saved Projects</h2>
        <div class="card-grid">
            <% if (savedProjects.isEmpty()) { %>
                <div class="card">
                    <p>You haven’t saved any projects yet.</p>
                </div>
            <% } else {
                for (Map<String, String> project : savedProjects) { %>
                <div class="card">
                    <h3><%= project.get("title") %></h3>
                    <p><strong>Category:</strong> <%= project.get("category") %></p>
                    <p><strong>Budget:</strong> ₹<%= project.get("budget") %></p>
                    <p><strong>Deadline:</strong> <%= project.get("deadline") %></p>
                    <p><strong>Posted:</strong> <%= project.get("posted_at") %></p>
                    <p><%= project.get("description") %></p>
                    <form action="UnsaveProjectServlet" method="post">
                        <input type="hidden" name="freelancer_name" value="<%= fullname %>">
                        <input type="hidden" name="project_id" value="<%= project.get("id") %>">
                        <button type="submit" class="save-btn">❌ Unsave</button>
                    </form>
                </div>
            <% } } %>
        </div>
    </section>

    <footer class="footer">
        <p>© 2025 TaskNest. Built with passion by Pathan.</p>
    </footer>
</body>
</html>