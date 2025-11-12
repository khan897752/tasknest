<%@ page import="java.util.*, com.tasknest.model.UserDBlogic" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");
    if (fullname == null || role == null || !"freelancer".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    String projectId = request.getParameter("id");
    Map<String, String> project = UserDBlogic.getProjectById1(projectId);
    if (project.isEmpty()) {
        response.sendRedirect("BrowseProjects.jsp?error=not_found");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Apply to Project | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/form.css"> 
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">
        <div class="logo">TaskNest</div>
        <div class="nav-links">
            <a href="freelancerDashboard.jsp">Home</a>
            <a href="BrowseProjects.jsp">Browse Projects</a>
            <a href="profile.jsp">Profile</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <section class="form-container">
        <h2>Apply to "<%= project.get("title") %>"</h2>
        <form action="ApplyProjectServlet" method="post">
            <input type="hidden" name="project_id" value="<%= project.get("id") %>">
            <input type="hidden" name="client_name" value="<%= project.get("client_name") %>">

            <div class="form-group">
                <label>Your Proposal</label>
                <textarea name="proposal" rows="5" required></textarea>
            </div>

            <div class="form-group">
                <label>Expected Budget (INR)</label>
                <input type="number" name="expected_budget" required>
            </div>

            <div class="form-group">
                <label>Estimated Completion Time (days)</label>
                <input type="number" name="estimated_days" required>
            </div>

            <div class="form-submit">
                <button type="submit">Submit Application</button>
            </div>
        </form>
    </section>

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