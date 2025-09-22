<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mvc.bean.User, com.mvc.dao.UserDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - MovieTime</title>
        <link rel="stylesheet" href="./css/style.css">

</head>
<body>

<div class="form-container">
    <h2>Create an Account</h2>

    <form action="signup.jsp" method="post">
        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>
        <button type="submit" class="btn btn-primary">Sign Up</button>
    </form>

      <%
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
		
        if(username != null && email != null && password != null) {
            User user = new User(username, password, email, "User");   
            UserDAO dao = new UserDAO();

            boolean registered = dao.registerUser(user);

            if(registered) {
    %>
                <p style="color:white;">Account created successfully! <a href="loginForm.jsp" style="color:red" >Login here</a></p>
    <%
            } else {
    %>
                <p style="color:white;">Registration failed. Email might already exist!</p>
    <%
            }
        }
    %>
</div>

</body>
</html>
