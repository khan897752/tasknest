<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% System.out.println("Rendering delivery form for projectId: " + request.getParameter("projectId")); %>
<!DOCTYPE html>
<html>
<head>
  <title>Submit Project Delivery</title>
  <link rel="stylesheet" href="css/submitDelivery.css">
</head>
<body>

  <!-- 🌐 Navbar -->
  <nav class="navbar">
    <div class="logo">TaskNest</div>
    <ul class="nav-links">
      <li><a href="index.jsp">Home</a></li>
      <li><a href="freelancerDashboard.jsp">Dashboard</a></li>
      <li><a href="about.jsp">About</a></li>
      <li><a href="logout.jsp">Logout</a></li>
    </ul>
  </nav>

  <!-- 📦 Delivery Form -->
  <div class="form-container">
    <h2>Submit Your Work</h2>
    <form action="submitDelivery" method="post" enctype="multipart/form-data">
      <input type="hidden" name="projectId" value="${param.projectId}">
      <input type="hidden" name="freelancerId" value="${param.freelancerId}">

      <label for="deliveryNote">Delivery Note:</label>
      <textarea name="deliveryNote" id="deliveryNote" required></textarea>

      <label for="deliveryFile">Upload File:</label>
      <input type="file" name="deliveryFile" id="deliveryFile" required>

      <label for="linkUrl">Live Link (optional):</label>
      <input type="url" name="linkUrl" id="linkUrl">

      <button type="submit" onclick="alert('Submitting...')">Submit</button>
    </form>
  </div>

</body>
</html>