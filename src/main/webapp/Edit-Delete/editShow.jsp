<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.mvc.dao.ShowtimeDAO, com.mvc.dao.MoviesDAO, com.mvc.bean.Showtime, com.mvc.bean.Movie" %>
<%@ include file="../header.jsp" %>

<%
    int showId = Integer.parseInt(request.getParameter("showId"));
    ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    MoviesDAO movieDAO = new MoviesDAO();

    Showtime show = showtimeDAO.getShowtimeById(showId);
    List<Movie> movies = movieDAO.getAllMovies();

    if (request.getMethod().equalsIgnoreCase("POST")) {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String theatre = request.getParameter("theatre");
        java.sql.Date showDate = java.sql.Date.valueOf(request.getParameter("showDate"));
        String showTime = request.getParameter("showTime");
        int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));

        boolean updated = showtimeDAO.updateShowtime(showId, movieId, theatre, showDate, showTime, totalSeats);
        if (updated) {
            response.sendRedirect(request.getContextPath() +"/admin.jsp");
        }
    }
%>

<div class="admin-container">

    <form method="post" action="editShow.jsp?showId=<%=showId%>" class="admin-form">
        <h2>Edit Show</h2>
        <label>Movie</label>
        <select name="movieId" required>
            <% for (Movie m : movies) { %>
                <option value="<%=m.getMovieId()%>" <%= m.getMovieId() == show.getMovieId() ? "selected" : "" %>><%=m.getTitle()%></option>
            <% } %>
        </select>
        <label>Theatre</label>
        <input type="text" name="theatre" value="<%=show.getTheatre()%>" required>
        <label>Date</label>
        <input type="date" name="showDate" value="<%=show.getShowDate()%>" required>
        <label>Time</label>
        <input type="time" name="showTime" value="<%=show.getShowTime()%>" required>
        <label>Total Seats</label>
        <input type="number" name="totalSeats" value="<%=show.getTotalSeats()%>" min="1" required>
        <button type="submit" class="btn">Update Show</button>
    </form>

</div>
