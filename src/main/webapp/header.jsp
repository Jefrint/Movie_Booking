<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="true"%>
<%@ page import="com.mvc.bean.User"%>

<!DOCTYPE html>
<html>
<head>
<title>MovieTime</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/header.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
	<header>
		<div class="logo">
			<span>M</span> MovieTime
		</div>
		<nav>
			<a href="/Movie_Booking/">Home</a> <a href="movies.jsp">Movies</a>
			<%
			// check if user session exists
			User user = (User) session.getAttribute("User");
			if (user != null) {
			%>
			
			  <% if ("Admin".equals(user.getUserType())) { %>
            <a href="admin.jsp">Admin Dashboard</a>
        <% } %>
			
			<a href="mytickets.jsp">My Tickets</a>
			
      

			<%
			}
			%>
			<a href="aboutus.jsp">About Us</a>
		</nav>

		<div class="actions">
			<%
			if (user == null) {
			%>
			<a href="loginForm.jsp">Sign In</a> <a href="signup.jsp"
				class="btn btn-primary">Sign Up</a>
			<%
			} else {
			%>
			<a href="logout.jsp" class="btn btn-primary">Logout</a>
			<%
			}
			%>
		</div>
	</header>
</body>
</html>
