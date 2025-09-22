<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mvc.dao.MoviesDAO, com.mvc.dao.ShowtimeDAO, com.mvc.bean.Movie, com.mvc.bean.Showtime" %>
<%@ include file="header.jsp" %>

<%
    MoviesDAO movieDAO = new MoviesDAO();
    ShowtimeDAO showtimeDAO = new ShowtimeDAO();

    User loggedUser = (User) session.getAttribute("User");

    // Check if user is logged in
    if (loggedUser == null) {
        response.sendRedirect("loginForm.jsp?redirect=" + request.getRequestURI());
        return;
    }

    // Only allow Admin users
    if (!"Admin".equalsIgnoreCase(loggedUser.getUserType())) {
        response.sendRedirect("loginForm.jsp?redirect=" + request.getRequestURI());
        return;
    }

    // Handle add movie
    String addMovieTitle = request.getParameter("movieTitle");
    if (addMovieTitle != null && !addMovieTitle.isEmpty()) {
        String genre = request.getParameter("genre");
        String language = request.getParameter("language");
        String duration = request.getParameter("duration");
        String description = request.getParameter("description");
        double rating = Double.parseDouble(request.getParameter("rating"));
        String url = request.getParameter("url");
        movieDAO.addMovie(addMovieTitle, genre, language, duration, description, rating, url);
    }

    // Handle add show
    String theatre = request.getParameter("theatre");
    if (theatre != null && !theatre.isEmpty()) {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        java.sql.Date showDate = java.sql.Date.valueOf(request.getParameter("showDate"));
        String showTime = request.getParameter("showTime");
        int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
        showtimeDAO.addShowtime(movieId, theatre, showDate, showTime, totalSeats, 0);
    }

    // Get all movies and shows
    List<Movie> movies = movieDAO.getAllMovies();
    List<Showtime> shows = showtimeDAO.getAllShowtimes();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="admin-container">

    <h1>🎬 Admin Dashboard</h1>

    <!-- Add Movie -->
    <h2>Add Movie</h2>
    <form method="post" action="admin.jsp" class="admin-form">
        <label>Movie Title</label>
        <input type="text" name="movieTitle" required>
        <label>Genre</label>
        <input type="text" name="genre" required>
        <label>Language</label>
        <input type="text" name="language" required>
        <label>Duration</label>
        <input type="text" name="duration" placeholder="e.g., 2h 15m" required>
        <label>Description</label>
        <textarea name="description" rows="3" required></textarea>
        <label>Rating</label>
        <input type="number" name="rating" min="0" max="10" step="0.1" required>
        <label>Poster URL</label>
        <input type="text" name="url" required>
        <button type="submit" class="btn">Add Movie</button>
    </form>

    <!-- Add Show -->
    <h2>Add Show</h2>
    <form method="post" action="admin.jsp" class="admin-form">
        <label>Movie</label>
        <select name="movieId" required>
            <option value="">-- Select Movie --</option>
            <% for (Movie m : movies) { %>
                <option value="<%=m.getMovieId()%>"><%=m.getTitle()%></option>
            <% } %>
        </select>
        <label>Theatre</label>
        <input type="text" name="theatre" required>
        <label>Date</label>
        <input type="date" name="showDate" required>
        <label>Time</label>
        <input type="time" name="showTime" required>
        <label>Total Seats</label>
        <input type="number" name="totalSeats" min="1" required>
        <button type="submit" class="btn">Add Show</button>
    </form>

    <!-- All Movies -->
    <h2>All Movies</h2>
    <table class="admin-table">
        <tr>
            <th>Movie ID</th>
            <th>Title</th>
            <th>Genre</th>
            <th>Language</th>
            <th>Duration</th>
            <th>Description</th>
            <th>Rating</th>
            <th>Actions</th>
        </tr>
        <% for (Movie m : movies) { %>
        <tr>
            <td><%=m.getMovieId()%></td>
            <td><%=m.getTitle()%></td>
            <td><%=m.getGenre()%></td>
            <td><%=m.getLanguage()%></td>
            <td><%=m.getDuration()%></td>
            <td><%=m.getDescription()%></td>
            <td><%=m.getRating()%></td>
            <td>
                <form action="Edit-Delete/editMovie.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="movieId" value="<%=m.getMovieId()%>">
                    <button type="submit" class="btn edit-btn">Edit</button>
                </form>
                <form action="Edit-Delete/deleteMovie.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="movieId" value="<%=m.getMovieId()%>">
                    <button type="submit" class="btn delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <!-- All Shows -->
    <h2>All Shows</h2>
    <table class="admin-table">
        <tr>
            <th>Show ID</th>
            <th>Movie</th>
            <th>Theatre</th>
            <th>Date</th>
            <th>Time</th>
            <th>Total Seats</th>
            <th>Booked Seats</th>
            <th>Actions</th>
        </tr>
        <% for (Showtime s : shows) { %>
        <tr>
            <td><%=s.getShowId()%></td>
            <td><%=movieDAO.getMovieById(s.getMovieId()).getTitle()%></td>
            <td><%=s.getTheatre()%></td>
            <td><%=s.getShowDate()%></td>
            <td><%=s.getShowTime()%></td>
            <td><%=s.getTotalSeats()%></td>
            <td><%=s.getBookedSeats()%></td>
            <td>
                <form action="Edit-Delete/editShow.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="showId" value="<%=s.getShowId()%>">
                    <button type="submit" class="btn edit-btn">Edit</button>
                </form>
                <form action="Edit-Delete/deleteShow.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="showId" value="<%=s.getShowId()%>">
                    <button type="submit" class="btn delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>

</div> <!-- admin-container -->

</body>
</html>
