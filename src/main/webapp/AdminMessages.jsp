<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.AdminDBLogic" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    List<Map<String, String>> messages = AdminDBLogic.getAllContactMessages();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel | Messages</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <style>
        .message-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }
        .message-table th, .message-table td {
            padding: 12px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            text-align: left;
        }
        .message-table th {
            background: rgba(255,255,255,0.1);
        }
        .message-table tr:hover {
            background: rgba(255,255,255,0.05);
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
            <a href="AdminAnalytics.jsp">Analytics</a>
            <a href="AdminMessages.jsp">Messages</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <section class="dashboard">
        <h2>📬 User Messages</h2>
        <table class="message-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Message</th>
                <th>Submitted At</th>
            </tr>
            <% for (Map<String, String> msg : messages) { %>
            <tr>
                <td><%= msg.get("name") %></td>
                <td><%= msg.get("email") %></td>
                <td><%= msg.get("role") %></td>
                <td><%= msg.get("message") %></td>
                <td><%= msg.get("submitted_at") %></td>
            </tr>
            <% } %>
        </table>
    </section>
</body>
</html>