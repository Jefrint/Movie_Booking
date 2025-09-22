<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.dao.MoviesDAO" %>
<%
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    MoviesDAO movieDAO = new MoviesDAO();
    movieDAO.deleteMovie(movieId);
    response.sendRedirect(request.getContextPath() + "/admin.jsp");

%>
