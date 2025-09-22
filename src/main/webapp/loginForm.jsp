<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="com.mvc.dao.UserDAO,com.mvc.bean.User,com.mvc.dao.DBDAO"%>

<!DOCTYPE html>
<html>
<head>
<title>Login - Movie Booking</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="form-container">
		<h2>Login to Movie Booking</h2>

		<form action="loginForm.jsp" method="post">
			<input type="hidden" name="redirect"
				value="<%=request.getParameter("redirect") != null ? request.getParameter("redirect") : "dashboard"%>" />

			<%
			if (request.getParameter("movieId") != null) {
			%>
			<input type="hidden" name="movieId"
				value="<%=request.getParameter("movieId")%>" />
			<%
			}
			%>

			<%
			if (request.getParameter("showId") != null) {
			%>
			<input type="hidden" name="showId"
				value="<%=request.getParameter("showId")%>" />
			<%
			}
			%>

			<label for="email">Email:</label> <input type="email" id="email"
				name="email" placeholder="Enter your email" required> <label
				for="password">Password:</label> <input type="password"
				id="password" name="password" placeholder="Enter your password"
				required>

			<button type="submit" class="btn btn-primary">Login</button>
		</form>


		<p>
			Don't have an account? <a href="signup.jsp" style="color: red">Sign
				up here</a>
		</p>

		<%
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String redirect = request.getParameter("redirect");

		if (email != null && password != null) {
			try {
				UserDAO dao = new UserDAO();
				User user = dao.LoginUser(email, password);

				if (user != null) {
			// ✅ Store in session
			session.setAttribute("User", user);
			if ("booking".equals(redirect)) {
				String movieId = request.getParameter("movieId");
				String showId = request.getParameter("showId");
				response.sendRedirect("booking.jsp?movieId=" + movieId + "&showId=" + showId);
			}else if("Admin".equals(user.getUserType())){
				response.sendRedirect("admin.jsp");

			}else {
				response.sendRedirect("movies.jsp");
			}

				} else {
		%>
		<p style="color: red;">Invalid email or password. Try again.</p>
		<%
		}
		} catch (Exception e) {
		e.printStackTrace();
		}
		}
		%>
	</div>
</body>
</html>
