<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || !"freelancer".equals(role)) {
        response.sendRedirect("login.jsp?error=session_expired");
        return;
    }

    Map<String, String> profile = UserDBlogic.getFreelancerProfile(fullname);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>
    <h2>👤 My Profile</h2>
    <div class="card">
        <p><strong>Name:</strong> <%= profile.get("fullname") %></p>
        <p><strong>Email:</strong> <%= profile.get("email") %></p>
        <p><strong>Skills:</strong> <%= profile.get("skills") %></p>
        <p><strong>Bio:</strong> <%= profile.get("bio") %></p>
    </div>
</body>
</html>