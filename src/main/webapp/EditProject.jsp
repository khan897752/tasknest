<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || role == null || !"client".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    String projectId = request.getParameter("id");
    Map<String, String> project = UserDBlogic.getProjectById(projectId, fullname);
    if (project.isEmpty()) {
        response.sendRedirect("ManageProjects.jsp?error=not_found");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Project | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background: rgba(255,255,255,0.1);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: none;
            font-family: 'Poppins', sans-serif;
            background: #fff;
        }

        .form-group textarea {
            resize: vertical;
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
            background: #FFCC4D;
            color: #000;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .form-submit button:hover {
            background: #ffd966;
        }

        .footer {
            text-align: center;
            padding: 20px;
            background: #fff;
            margin-top: 60px;
            font-size: 14px;
            color: #555;
        }

        .footer-links a {
            margin: 0 10px;
            color: #6a4c93;
            text-decoration: none;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- 🔝 Navbar -->
    <nav class="navbar">
        <div class="logo">TaskNest</div>
        <div class="nav-links">
            <a href="dashboard.jsp">Home</a>
            <a href="ManageProjects.jsp">My Projects</a>
            <a href="profile.jsp">Profile</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <!-- ✏️ Edit Form -->
    <section class="form-container">
        <h2>Edit Project</h2>
        <form action="UpdateProjectServlet" method="post">
            <input type="hidden" name="id" value="<%= project.get("id") %>">

            <div class="form-group">
                <label for="title">Project Title</label>
                <input type="text" id="title" name="title" value="<%= project.get("title") %>" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required><%= project.get("description") %></textarea>
            </div>

            <div class="form-group">
                <label for="budget">Budget (INR)</label>
                <input type="number" id="budget" name="budget" value="<%= project.get("budget") %>" required>
            </div>

            <div class="form-group">
                <label for="deadline">Deadline</label>
                <input type="date" id="deadline" name="deadline" value="<%= project.get("deadline") %>" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <select id="category" name="category" required>
                    <option value="">Select</option>
                    <option value="Web Development" <%= "Web Development".equals(project.get("category")) ? "selected" : "" %>>Web Development</option>
                    <option value="Design" <%= "Design".equals(project.get("category")) ? "selected" : "" %>>Design</option>
                    <option value="Writing" <%= "Writing".equals(project.get("category")) ? "selected" : "" %>>Writing</option>
                    <option value="Marketing" <%= "Marketing".equals(project.get("category")) ? "selected" : "" %>>Marketing</option>
                    <option value="Other" <%= "Other".equals(project.get("category")) ? "selected" : "" %>>Other</option>
                </select>
            </div>

            <div class="form-submit">
                <button type="submit">Update Project</button>
            </div>
        </form>
    </section>

    <!-- 🔻 Footer -->
    <footer class="footer">
        <p>© 2025 TaskNest. Built with passion by Pathan.</p>
        <div class="footer-links">
            <a href="about.jsp">About</a>
            <a href="profile.jsp">Profile</a>
            <a href="mailto:support@tasknest.com">Contact</a>
        </div>
    </footer>
</body>
</html>