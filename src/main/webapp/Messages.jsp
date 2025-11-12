<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>

<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");

    if (fullname == null) {
        response.sendRedirect("login.jsp?error=session_expired");
        return;
    }

    List<Map<String, String>> messages = UserDBlogic.getMessages(fullname);
    List<Map<String, String>> applications = null;

    if ("client".equals(role)) {
        applications = UserDBlogic.getApplicationsByClient(fullname);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Messages</title>
    <link rel="stylesheet" href="css/dashboard.css">
    <style>
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 10px 20px;
            margin: 10px 30px;
            border-radius: 5px;
            font-weight: bold;
        }
        textarea {
            width: 100%;
            height: 80px;
            margin-top: 8px;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            margin-top: 8px;
            padding: 8px 16px;
            background-color: #ff6b6b;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>💬 Messages</h2>

    <% if (request.getParameter("success") != null) { %>
        <div class="success-message">
            <%= request.getParameter("success") %>
        </div>
    <% } %>

    <div class="card-grid">
        <% if ("client".equals(role)) { %>
            <% for (Map<String, String> app : applications) { %>
                <div class="card">
                    <p><strong>Freelancer:</strong> <%= app.get("freelancer_name") %></p>
                    <p><strong>Project ID:</strong> <%= app.get("project_id") %></p>
                    <form action="SendMessageServlet" method="post">
                        <input type="hidden" name="sender" value="<%= fullname %>">
                        <input type="hidden" name="receiver" value="<%= app.get("freelancer_name") %>">
                        <input type="hidden" name="project_id" value="<%= app.get("project_id") %>">
                        <textarea name="message" placeholder="Type your message..." required></textarea>
                        <button type="submit">Send Message</button>
                    </form>
                </div>
            <% } %>
        <% } else { %>
            <% for (Map<String, String> msg : messages) { %>
                <div class="card">
                    <p><strong>From:</strong> <%= msg.get("sender") %></p>
                    <p><strong>Project ID:</strong> <%= msg.get("project_id") %></p>
                    <p><strong>Message:</strong></p>
                    <p><%= msg.get("message") %></p>
                    <p><small>Sent at: <%= msg.get("sent_at") %></small></p>
                    
                     <form action="SendMessageServlet" method="post">
                         <input type="hidden" name="sender" value="<%= fullname %>">
                         <input type="hidden" name="receiver" value="<%= msg.get("sender") %>">
                         <input type="hidden" name="project_id" value="<%= msg.get("project_id") %>">
                         <textarea name="message" placeholder="Reply to this message..." required></textarea>
                         <button type="submit">Send Reply</button>
                    </form>
                    
                </div>
            <% } %>
        <% } %>
    </div>
</body>
</html>