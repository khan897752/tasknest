<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tasknest.model.AdminDBLogic" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    int totalUsers = AdminDBLogic.getUserCount();
    int totalProjects = AdminDBLogic.getProjectCount();
    int monthlySignups = AdminDBLogic.getMonthlySignups();
    double avgBudget = AdminDBLogic.getAverageBudget();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel | Analytics</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .card.metric {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }
        .card.metric h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .card.metric p {
            font-size: 24px;
            font-weight: bold;
            color: #fff;
        }
        
        canvas {
    margin-top: 20px;
    max-width: 100%;
    background: rgba(255,255,255,0.05);
    border-radius: 12px;
    padding: 10px;
  }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">TaskNest Admin</div>
        <div class="nav-links">
            <a href="AdminDashboard.jsp">Dashboard</a>
            <a href="AdminUsers.jsp">Users</a>
            <a href="AdminProjects.jsp">Projects</a>
            <a href="AdminAnalytics.jsp">Analytics</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <section class="dashboard">
        <h2>📊 Platform Analytics Overview</h2>

        <div class="analytics-grid">
            <div class="card metric">
                <h3>Total Registered Users</h3>
                <p><%= totalUsers %></p>
            </div>
            <div class="card metric">
                <h3>Total Projects Posted</h3>
                <p><%= totalProjects %></p>
            </div>
            <div class="card metric">
                <h3>New Signups This Month</h3>
                <p><%= monthlySignups %></p>
            </div>
            <div class="card metric">
                <h3>Average Project Budget</h3>
                <p>₹<%= String.format("%.2f", avgBudget) %></p>
            </div>
        </div>
        
        <h3 style="margin-top: 40px;">📈 Monthly Signups Trend</h3>
        <canvas id="signupChart" width="400" height="200"></canvas>
    </section>
    
    <script>
    const ctx = document.getElementById('signupChart').getContext('2d');
    const signupChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
            datasets: [{
                label: 'Signups',
                data: [12, 19, 14, 22, 17, <%= monthlySignups %>],
                backgroundColor: 'rgba(255, 255, 255, 0.2)',
                borderColor: '#fff',
                borderWidth: 2,
                tension: 0.3,
                fill: true,
                pointBackgroundColor: '#ffd6e0'
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { color: '#fff' },
                    grid: { color: 'rgba(255,255,255,0.1)' }
                },
                x: {
                    ticks: { color: '#fff' },
                    grid: { color: 'rgba(255,255,255,0.1)' }
                }
            },
            plugins: {
                legend: { labels: { color: '#fff' } }
            }
        }
    });
   </script>
</body>
</html>