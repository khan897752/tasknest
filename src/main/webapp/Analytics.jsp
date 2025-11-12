<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || !"client".equals(role)) {
        response.sendRedirect("login.jsp?error=session_expired");
        return;
    }

    List<Map<String, String>> analytics = UserDBlogic.getProjectAnalytics(fullname);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Project Analytics</title>
    <link rel="stylesheet" href="css/dashboard.css">
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
     
    <h2>📊 Project Analytics for <%= fullname %></h2>
    <div class="card-grid">
        <% for (Map<String, String> data : analytics) { %>
            <div class="card">
                <p><strong>Project ID:</strong> <%= data.get("project_id") %></p>
                <p><strong>Total Applications:</strong> <%= data.get("total_applications") %></p>
                <p><strong>Average Budget:</strong> ₹<%= data.get("avg_budget") %></p>
                <p><strong>Average Days:</strong> <%= data.get("avg_days") %></p>
            </div>
        <% } %>
    </div>
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