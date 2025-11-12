<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.AdminDBLogic" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    List<Map<String, String>> projects = AdminDBLogic.getAllProjects();
    String status = request.getParameter("status");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel | Projects</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo">TaskNest Admin</div>
        <div class="nav-links">
            <a href="AdminDashboard.jsp">Dashboard</a>
            <a href="AdminUsers.jsp">Users</a>
            <a href="AdminProjects.jsp">Projects</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <section class="dashboard">
        <h2>📁 All Posted Projects</h2>

        <% if ("deleted".equals(status)) { %>
            <div class="alert-card success">✅ Project deleted successfully.</div>
        <% } else if ("error".equals(status)) { %>
            <div class="alert-card error">⚠️ Failed to delete project.</div>
        <% } %>

        <table class="user-table">
            <tr>
                <th>Title</th>
                <th>Category</th>
                <th>Budget</th>
                <th>deadline</th>
                <th>Action</th>
            </tr>
            <% for (Map<String, String> project : projects) { %>
            <tr>
                <td><%= project.get("title") %></td>
                <td><%= project.get("category") %></td>
                <td><%= project.get("budget") %></td>
                <td><%= project.get("deadline") %></td>
                <td>
                    <form action="DeleteProjectServletBYAdmin" method="post">
                        <input type="hidden" name="projectId" value="<%= project.get("id") %>">
                        <button type="submit" class="delete-btn">🗑️ Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </section>

    <script>
        setTimeout(() => {
            const alert = document.querySelector('.alert-card');
            if (alert) {
                alert.style.opacity = '0';
                alert.style.transition = 'opacity 0.5s ease';
                setTimeout(() => alert.remove(), 500);
            }
        }, 3000);
    </script>
</body>
</html>