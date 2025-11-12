<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("adminLogin.jsp?error=unauthorized");
        return;
    }

    String fullname = (String) session.getAttribute("fullname");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/AdminDashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style type="text/css">
        
.card-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 24px;
    margin-top: 30px;
}

.card {
    display: block;
    background: rgba(255, 255, 255, 0.15);
    padding: 30px;
    border-radius: 20px;
    color: #fff;
    text-decoration: none;
    font-weight: 500;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    transition: transform 0.3s ease;
    width: 260px;
    text-align: center;
}

.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 40px rgba(0,0,0,0.4);
}

.footer {
    text-align: center;
    padding: 30px 20px;
    font-size: 14px;
    color: #fff;
    background: rgba(0, 0, 0, 0.1);
    margin-top: 60px;
    border-top: 1px solid rgba(255, 255, 255, 0.2);
}
.footer p {
    margin: 6px 0;
}
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">TaskNest Admin</div>
        <nav class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="about.jsp">About</a>
            <a href="AdminProjects.jsp">Projects</a>
            <a href="AdminAnalytics.jsp">Analytics</a>
            <a href="LogoutServlet">Logout</a>
        </nav>
    </div>

    <section class="dashboard">
        <h2>👋 Welcome, <%= fullname %></h2>
        <p>Use the cards below to manage users, projects, and monitor platform activity.</p>

        <div class="card-grid">
            <a href="AdminUsers.jsp" class="card">👥 Manage Users</a>
            <a href="AdminProjects.jsp" class="card">📁 Manage Projects</a>
            <a href="AdminAnalytics.jsp" class="card">📊 View Analytics</a>
            <a href="AdminMessages.jsp" class="card">📬 View Messages</a>
        </div>
    </section>
    
    <footer class="footer">
    <p>&copy; 2025 TaskNest Admin Panel. All rights reserved.</p>
    <p>Built with passion by Pathan</p>
</footer>
</body>
</html>