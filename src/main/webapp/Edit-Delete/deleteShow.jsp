<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.dao.ShowtimeDAO" %>
<%
    int showId = Integer.parseInt(request.getParameter("showId"));
    ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    showtimeDAO.deleteShowtime(showId);
    response.sendRedirect(request.getContextPath() + "/admin.jsp");
%>
