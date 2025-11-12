<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String userEmail = (String) session.getAttribute("email");
    boolean isLoggedIn = userEmail != null;
    String status = request.getParameter("status");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact | TaskNest</title>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="css/contact.css">
</head>
<body>

<header class="navbar">
    <div class="logo">TaskNest</div>
    <nav>
        <a href="ApplyProject.jsp">Find Work</a>
        <a href="PostProject.jsp">Post Job</a>
        <a href="about.jsp">About</a>
        <a href="index.jsp">Home</a>
    </nav>
</header>

<div class="contact-container">
    <h2>Contact TaskNest Admin</h2>

    <% if ("sent".equals(status)) { %>
        <div class="alert-card success">✅ Message sent successfully!</div>
    <% } else if ("error".equals(status)) { %>
        <div class="alert-card error">⚠️ Failed to send message. Try again.</div>
    <% } %>

    <% if (isLoggedIn) { %>
    <form action="ContactServlet" method="post">
        <label for="name">Your Name</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Your Email</label>
        <input type="email" id="email" name="email" value="<%= userEmail %>" readonly>

        <label for="role">Are you a Client or Freelancer?</label>
        <input type="text" id="role" name="role" placeholder="e.g., Freelancer" required>

        <label for="message">Your Message</label>
        <textarea id="message" name="message" rows="6" required></textarea>

        <button type="submit">Send Message</button>
    </form>
    <% } else { %>
    <div class="alert-card error" style="margin-top: 20px;">
        ⚠️ You must <a href="login.jsp" style="color:#ffd6e0;">log in</a> to send a message.
    </div>
    <% } %>
</div>

</body>
</html>