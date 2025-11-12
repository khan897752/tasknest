<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.AdminDBLogic" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    List<Map<String, String>> users = AdminDBLogic.getAllUsers();
    String status = request.getParameter("status");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel | Users</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <style type="text/css">
      .alert-card {
    opacity: 1;
    transition: opacity 0.5s ease;
}
    </style>
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
        <h2>👥 All Registered Users</h2>

        <% if ("deleted".equals(status)) { %>
            <div class="alert-card success">✅ User deleted successfully.</div>
        <% } else if ("error".equals(status)) { %>
            <div class="alert-card error">⚠️ Failed to delete user. Try again.</div>
        <% } %>

        <table class="user-table">
            <tr>
                <th>Full Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <% for (Map<String, String> user : users) { %>
            <tr>
                <td><%= user.get("fullname") %></td>
                <td><%= user.get("email") %></td>
                <td><%= user.get("role") %></td>
                <td>
                    <form action="DeleteUserServlet" method="post">
                        <input type="hidden" name="email" value="<%= user.get("email") %>">
                        <button type="submit" class="delete-btn">🗑️ Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </section>
    
    <script>
    // Auto-dismiss alert after 3 seconds
    setTimeout(() => {
        const alert = document.querySelector('.alert-card');
        if (alert) {
            alert.style.opacity = '0';
            alert.style.transition = 'opacity 0.5s ease';
            setTimeout(() => alert.remove(), 500); // Remove from DOM after fade
        }
    }, 3000);
</script>
</body>
</html>