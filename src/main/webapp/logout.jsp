<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%
    session.invalidate();   // clear session
    response.sendRedirect("movies.jsp"); // redirect to home/movies page
%>