<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>TaskNest</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/index.css">
  <link rel="stylesheet" href="css/extra.css">
  <link rel="stylesheet" href="css/responsive.css">
  <style type="text/css">    
  .how-it-works {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 80px 40px;
  text-align: center;
  box-sizing: border-box;
}

.how-it-works h2 {
  font-size: 32px;
  margin-bottom: 50px;
  color: #fff;
  font-weight: 600;
  animation: fadeSlide 1s ease-out forwards;
  opacity: 0;
}

/* 🧩 Step Cards */
.steps {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 40px;
}

.step-card {
  background: rgba(255, 255, 255, 0.1);
  padding: 30px;
  border-radius: 20px;
  width: 260px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  backdrop-filter: blur(10px);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  animation: fadeSlide 1.2s ease-out forwards;
  opacity: 0;
}

.step-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 12px 40px rgba(0,0,0,0.4);
}

.step-card span {
  font-size: 36px;
  display: block;
  margin-bottom: 16px;
}

.step-card h3 {
  font-size: 20px;
  margin-bottom: 12px;
  color: #fff;
  font-weight: 600;
}

.step-card p {
  font-size: 15px;
  color: #eee;
  line-height: 1.6;
}  

@keyframes fadeSlide {
  0% {
    opacity: 0;
    transform: translateY(20px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

.float-animation {
  display: block;
  width: 400px;
  animation: float 3s ease-in-out infinite;
  position: relative;
  will-change: transform;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}
      
  </style>
</head>
<body>
  <!-- 🌈 Gradient Background -->
  <div class="gradient-bg">

    <!-- 1️ Navigation Bar -->
    <header class="navbar">
      <div class="logo">TaskNest</div>
      <nav>
        <a href="ApplyProject.jsp">Find Work</a>
        <a href="PostProject.jsp">Post Job</a>
        <a href="about.jsp">About</a>
        <a href="Contactme.jsp">Contact</a>
      </nav>
      <div class="nav-buttons">
        <a href="login.jsp" class="btn login">Login</a>
        <a href="role.jsp" class="btn signup">Sign Up</a>
      </div>
    </header>

    <!-- 2️ Hero Section -->
    <section class="hero">
      <div class="hero-left">
        <h1 class="fade-slide">Hire Freelancers. Work Smarter. Grow Faster.</h1>
        <p>Join TaskNest — a trusted platform connecting clients and freelancers worldwide.</p>
        <div class="hero-buttons">
          <a href="role.jsp" class="btn primary">Get Started</a>
          <a href="about.jsp" class="btn secondary">Learn More</a>
        </div>
      </div>
      <div class="hero-right">
        <img src="images/hero-image.jpg" alt="Hero Illustration" class="float-animation">
      </div>
    </section>

    <!-- 3️ Features Section -->
    <section class="features">
      <div class="feature-card">
        <span>💼</span>
        <h3>Post Your Job Easily</h3>
      </div>
      <div class="feature-card">
        <span>🧑‍💻</span>
        <h3>Hire Verified Freelancers</h3>
      </div>
      <div class="feature-card">
        <span>💰</span>
        <h3>Secure Payments</h3>
      </div>
    </section>

<!-- 4️ How TaskNest Works Section -->
<section class="how-it-works">
  <h2>How TaskNest Works</h2>
  <div class="steps">
    <div class="step-card">
      <span>📝</span>
      <h3>Create Your Profile</h3>
      <p>Sign up as a freelancer and set up your professional profile.</p>
    </div>
    <div class="step-card">
      <span>📢</span>
      <h3>Post or Apply for Projects</h3>
      <p>Clients post projects – it’s fast, simple, and secure.</p>
    </div>
    <div class="step-card">
      <span>🤝</span>
      <h3>Collaborate and Deliver</h3>
      <p>Share files and complete work directly on TaskNest.</p>
    </div>
    <div class="step-card">
      <span>💳</span>
      <h3>Get Paid Securely</h3>
      <p>Clients pay through TaskNest’s secure system once work is approved.</p>
    </div>
  </div>
</section>

    <!-- 5️ Call to Action -->
    <section class="cta">
      <h2>Ready to start your freelancing journey?</h2>
      <a href="role.jsp" class="btn cta-btn">Join TaskNest Today!</a>
    </section>

    <!-- 6️ Footer -->
    <footer>
      <div class="footer-links">
        <a href="adminLogin.jsp" style="font-size:12px;">Admin Login</a>
        <a href="about.jsp">About</a>
        <a href="terms.jsp">Terms</a>
        <a href="privacy.jsp">Privacy</a>
        <a href="mailto:support@tasknest.com">Contact</a>
      </div>
      <p>© TaskNest 2025 | Built with passion by Farhat Nawaz Khan</p>
    </footer>

  </div>
</body>
</html>