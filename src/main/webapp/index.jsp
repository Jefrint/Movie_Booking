<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>MovieTime - Book Your Tickets Online</title>
  <style>

    .hero {
      text-align: center;
      padding: 100px 20px;
      background: linear-gradient(to bottom, #0a0a0a, #111);
    }
    .hero .tag {
      display: inline-block;
      padding: 6px 14px;
      border-radius: 20px;
      background: #111;
      border: 1px solid #444;
      font-size: 12px;
      margin-bottom: 20px;
      color: #ccc;
    }
    .hero h1 {
      font-size: 48px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .hero p {
      font-size: 18px;
      color: #bbb;
      max-width: 700px;
      margin: 0 auto 30px;
    }
    .hero-buttons {
      margin: 20px 0;
    }
    .hero-buttons .btn {
      margin: 0 10px;
      padding: 12px 24px;
      font-size: 16px;
      border-radius: 25px;
    }
    .hero-features {
      margin-top: 20px;
      font-size: 14px;
      color: #777;
    }
    .hero-features span {
      margin: 0 10px;
    }
  </style>
</head>
<body>
 

  <!-- Hero Section -->
  <section class="hero">
    <div class="tag">Now Showing</div>
    <h1>Book Your Favorite Movies<br>Anytime, Anywhere</h1>
    <p>
      Welcome to <b>MovieTime</b>, your one-stop solution for booking tickets hassle-free. 
      Browse the latest movies, check showtimes, and grab your seats instantly.
    </p>
    <div class="hero-buttons">
      <a href="movies.jsp"  class="btn btn-primary" >Browse Movies →</a>
    
    </div>
    <div class="hero-features">
      <span>✔ Easy booking</span>
      <span>✔ Secure payments</span>
      <span>✔ Instant confirmation</span>
    </div>
  </section>
</body>
</html>
