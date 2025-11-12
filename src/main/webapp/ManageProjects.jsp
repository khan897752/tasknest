<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || role == null || !"client".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    List<Map<String, String>> projects = UserDBlogic.getProjectsByClient(fullname);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Projects | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        .dashboard h2 {
            font-size: 28px;
            background: linear-gradient(to right, #f15bb5, #fcbf49);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 40px;
        }

        .card h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 15px;
            margin: 6px 0;
        }

        .card::before {
            content: "📁";
            font-size: 24px;
            display: block;
            margin-bottom: 10px;
        }

        .card:hover {
            background: rgba(255, 255, 255, 0.35);
            transform: scale(1.02);
        }

        .empty-card {
            background: rgba(255,255,255,0.15);
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            font-size: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .empty-card::before {
            content: "📝";
            font-size: 40px;
            display: block;
            margin-bottom: 10px;
        }

        .delete-btn {
             margin-left: 10px;
    padding: 8px 16px;
    background: #6a4c93;
    color: #fff;
    border-radius: 8px;
    font-weight: 600;
    text-decoration: none;
    display: inline-block;
    transition: background 0.3s ease;
        }

        .delete-btn:hover {
            background: #7e5ca5;
        }
        
        .edit-btn {
    margin-left: 10px;
    padding: 8px 16px;
    background: #6a4c93;
    color: #fff;
    border-radius: 8px;
    font-weight: 600;
    text-decoration: none;
    display: inline-block;
    transition: background 0.3s ease;
   }

   .edit-btn:hover {
      background: #7e5ca5;
   }
    </style>
</head>
<body>
    <!-- 🔝 Navbar -->
    <nav class="navbar">
        <div class="logo">TaskNest</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="clientDashboard.jsp">Dashboard</a>
            <a href="PostProject.jsp">Post Project</a>
            <a href="about.jsp">About</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <!-- 📋 Project List -->
    <section class="dashboard">
        <h2>My Posted Projects</h2>

        <div class="card-grid">
            <%
                if (projects.isEmpty()) {
            %>
                <div class="empty-card">
                    <p>No projects posted yet. Start by clicking <strong>Post Project</strong> above!</p>
                </div>
            <%
                } else {
                    for (Map<String, String> project : projects) {
            %>
                <div class="card">
                    <h3><%= project.get("title") %></h3>
                    <p><strong>Category:</strong> <%= project.get("category") %></p>
                    <p><strong>Budget:</strong> ₹<%= project.get("budget") %></p>
                    <p><strong>Deadline:</strong> <%= project.get("deadline") %></p>
                    <p><strong>Posted:</strong> <%= project.get("posted_at") %></p>
                    <p><%= project.get("description") %></p>

                    <form action="DeleteProjectServlet" method="post">
                        <input type="hidden" name="projectId" value="<%= project.get("id") %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                    
                    <a href="EditProject.jsp?id=<%= project.get("id") %>" class="edit-btn">Edit</a>
                </div>
            <%
                    }
                }
            %>
        </div>
    </section>

    <!-- 🔻 Footer -->
    <footer class="footer">
        <p>© 2025 TaskNest. Built with passion by Pathan.</p>
        <div class="footer-links">
            <a href="about.jsp">About</a>
            <a href="terms.jsp">Terms</a>
            <a href="privacy.jsp">Privacy</a>
            <a href="mailto:support@tasknest.com">Contact</a>
        </div>
    </footer>
</body>
</html>