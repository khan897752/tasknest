<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || !"freelancer".equals(role)) {
        response.sendRedirect("login.jsp?error=session_expired");
        return;
    }

    List<Map<String, String>> applications = UserDBlogic.getApplicationsByFreelancer(fullname);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>
    <h2>📋 My Applications</h2>
    <div class="card-grid">
        <% for (Map<String, String> app : applications) { %>
            <div class="card">
                <p><strong>Project:</strong> <%= app.get("title") %></p>
                <p><strong>Description:</strong> <%= app.get("description") %></p>
                <p><strong>Budget:</strong> ₹<%= app.get("expected_budget") %></p>
                <p><strong>Timeline:</strong> <%= app.get("estimated_days") %> days</p>
                <p><small>Applied on: <%= app.get("applied_at") %></small></p>
            </div>
        <% } %>
    </div>
</body>
</html>