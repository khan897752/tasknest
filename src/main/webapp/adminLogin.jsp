<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | TaskNest</title>
    <style>
        /* 🌐 Global Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #9b5de5, #f15bb5, #fcbf49);
            color: #fff;
            margin: 0;
            padding: 0;
        }

        /* 🧭 Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.05);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .logo {
            font-size: 22px;
            font-weight: 600;
        }
        .nav-links a {
            color: #fff;
            margin-left: 20px;
            text-decoration: none;
            font-weight: 500;
        }
        .nav-links a:hover {
            color: #ffd6e0;
        }

        /* 🔐 Login Box */
        .login-container {
            max-width: 400px;
            margin: 80px auto;
            background: rgba(255, 255, 255, 0.05);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(12px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 26px;
            color: #fff;
        }
        .login-container input {
            width: 100%;
            padding: 14px;
            margin-bottom: 20px;
            border: none;
            border-radius: 12px;
            background: rgba(255,255,255,0.1);
            color: #fff;
            font-size: 14px;
        }
        .login-container input::placeholder {
            color: rgba(255,255,255,0.6);
        }
        .login-container button {
            width: 100%;
            padding: 12px;
            background: #ffd6e0;
            color: #000;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .login-container button:hover {
            background: #fcbf49;
        }

        /* ✅ Alerts */
        .alert-card {
            margin-bottom: 20px;
            padding: 16px;
            border-radius: 12px;
            font-weight: 500;
            backdrop-filter: blur(8px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .alert-card.success {
            background: rgba(0, 255, 0, 0.2);
            color: #fff;
        }
        .alert-card.error {
            background: rgba(255, 0, 0, 0.2);
            color: #fff;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="logo">TaskNest Admin</div>
        <nav class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="about.jsp">About</a>
            <a href="Contactme.jsp">Contact</a>
        </nav>
    </div>

    <div class="login-container">
        <h2>Admin Login</h2>

        <% if ("unauthorized".equals(error)) { %>
            <div class="alert-card error">⚠️ Unauthorized access. Please log in first.</div>
        <% } else if ("invalid".equals(error)) { %>
            <div class="alert-card error">❌ Invalid credentials. Try again.</div>
        <% } %>

        <form action="AdminLoginServlet" method="post">
            <input type="email" name="email" placeholder="Admin Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
            <div class="signup-link">
    <a href="ForgotAdminPassword.jsp">Forgot Password?</a>
    </div>
        </form>
    </div>

</body>
</html>