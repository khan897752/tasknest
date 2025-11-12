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
    <title>Edit Profile | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 60px auto;
            background: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #6a4c93;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: 600;
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group img {
            max-width: 120px;
            border-radius: 50%;
            margin-top: 10px;
        }

        .form-submit {
            text-align: center;
            margin-top: 30px;
        }

        .form-submit button {
            padding: 12px 30px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            background: #6a4c93;
            color: #fff;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .form-submit button:hover {
            background: #7e5abf;
        }
    </style>
</head>
<body>

<!-- 🔝 Navbar -->
<nav class="navbar">
    <div class="logo">TaskNest</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="freelancerDashboard.jsp">Dashboard</a>
        <a href="BrowseProjects.jsp">Projects</a>
        <a href="MyProfile.jsp">My Profile</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</nav>

<!-- ✏️ Profile Form -->
<section class="form-container">
    <h2>Edit Your Profile</h2>
    <form action="SaveProfileServlet" method="post">
        <input type="hidden" name="fullname" value="<%= fullname %>">

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" value="<%= profile.get("email") != null ? profile.get("email") : "" %>" required>
        </div>

        <div class="form-group">
            <label>Skills</label>
            <textarea name="skills" rows="3" required><%= profile.get("skills") != null ? profile.get("skills") : "" %></textarea>
        </div>

        <div class="form-group">
            <label>Bio</label>
            <textarea name="bio" rows="4"><%= profile.get("bio") != null ? profile.get("bio") : "" %></textarea>
        </div>
        <div class="form-submit">
            <button type="submit">Save Profile</button>
        </div>
    </form>
</section>

</body>
</html>