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
    if (projectId == null || projectId.trim().isEmpty()) {
        response.sendRedirect("ManageProjects.jsp?error=not_found");
        return;
    }

    List<Map<String, String>> applications = UserDBlogic.getApplicationsByProjectId(projectId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Applications | TaskNest</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/browse.css"> 
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">
        <div class="logo">TaskNest</div>
        <div class="nav-links">
            <a href="clientDashboard.jsp">Dashboard</a>
            <a href="ManageProjects.jsp">My Projects</a>
            <a href="about.jsp">About</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <section class="dashboard">
        <h2>Applications for "<%= project.get("title") %>"</h2>

        <div class="card-grid">
            <%
                if (applications.isEmpty()) {
            %>
                <div class="card">
                    <p>No applications received yet.</p>
                </div>
            <%
                } else {
                    for (Map<String, String> app : applications) {
            %>
                <div class="card">
                    <h3><%= app.get("freelancer_name") %></h3>
                    <p><strong>Proposal:</strong></p>
                    <p><%= app.get("proposal") %></p>
                    <p><strong>Expected Budget:</strong> ₹<%= app.get("expected_budget") %></p>
                    <p><strong>Estimated Days:</strong> <%= app.get("estimated_days") %> days</p>
                    <p><strong>Applied At:</strong> <%= app.get("applied_at") %></p>
                    <form action="AssignProjectServlet" method="post" style="margin-top: 10px;">
                             <input type="hidden" name="project_id" value="<%= app.get("project_id") %>">
                             <input type="hidden" name="freelancer_name" value="<%= app.get("freelancer_name") %>">
                             <button type="submit">Assign Project</button>
                   </form>
                </div>
            <%
                    }
                }
            %>
        </div>
    </section>

    <footer class="footer">
        <p>© 2025 TaskNest. Built with passion by Pathan.</p>
        <div class="footer-links">
            <a href="terms.jsp">Terms</a>
            <a href="privacy.jsp">Privacy</a>
            <a href="mailto:support@tasknest.com">Contact</a>
        </div>
    </footer>
    
    
    <script>
  window.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get("assigned") === "true") {
      alert("✅ Project assigned successfully!");
    }
  });
</script>
</body>
</html>