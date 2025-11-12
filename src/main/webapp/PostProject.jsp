<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || role == null || !"client".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Post a Project | TaskNest</title>
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
    </style>
</head>
<body>
    <!-- 🔝 Navbar -->
    <nav class="navbar">
        <div class="logo">TaskNest</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="clientDashboard.jsp">Dashboard</a>
            <a href="about.jsp">About</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <!-- 📝 Project Form -->
    <section class="form-container">
        <h2>Post a New Project</h2>
        <form action="PostProjectServlet" method="post">
            <div class="form-group">
                <label for="title">Project Title</label>
                <input type="text" id="title" name="title" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <label for="budget">Budget (INR)</label>
                <input type="number" id="budget" name="budget" required>
            </div>

            <div class="form-group">
                <label for="deadline">Deadline</label>
                <input type="date" id="deadline" name="deadline" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <select id="category" name="category" required>
                    <option value="">Select</option>
                    <option value="Web Development">Web Development</option>
                    <option value="Design">Design</option>
                    <option value="Writing">Writing</option>
                    <option value="Marketing">Marketing</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-submit">
                <button type="submit">Submit Project</button>
            </div>
        </form>
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