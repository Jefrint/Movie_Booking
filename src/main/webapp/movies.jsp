<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.mvc.dao.MoviesDAO,com.mvc.dao.ShowtimeDAO,com.mvc.bean.Movie,com.mvc.bean.Showtime,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Now Showing - CineBook</title>
<link rel="stylesheet" href="style.css">
<script>
    function bookTicket(movieId) {
        const selectedShow = document.querySelector('input[name="show_'+movieId+'"]:checked');
        if (!selectedShow) {
            alert("Please select a showtime first!");
            return;
        }
        const showId = selectedShow.value;
        const userLoggedIn = "<%= (session.getAttribute("User") != null) %>";
        
        if (userLoggedIn === "true") {
            window.location.href = "booking.jsp?movieId=" + movieId + "&showId=" + showId;
        } else {
            window.location.href = "loginForm.jsp?redirect=booking&movieId=" + movieId + "&showId=" + showId;
        }
    }
</script>
</head>
<body>

<%@ include file="header.jsp"%>

<section class="movies-section">
    <h2 class="section-title">Now Showing</h2>
    <p class="section-subtitle">Discover the latest movies and book your tickets</p>

    <div class="movies-grid">
        <%
        MoviesDAO movieDAO = new MoviesDAO();
        ShowtimeDAO showtimeDAO = new ShowtimeDAO();

        List<Movie> movies = movieDAO.getAllMovies();

        if (movies != null && !movies.isEmpty()) {
            for (Movie m : movies) {
                List<Showtime> showtimes = showtimeDAO.getShowtimesByMovieId(m.getMovieId());
        %>
        <!-- Movie Card -->
        <div class="movie-card">
            <img src="<%=m.getURL()%>" alt="<%=m.getTitle()%>">

            <div class="movie-info">
                <h3><%=m.getTitle()%></h3>
                <p><%=m.getGenre()%></p>
                <p>⏱ <%=m.getDuration()%> | ⭐ <%=m.getRating()%></p>
                <p><%=m.getDescription()%></p>

                <div class="showtimes">
                    <%
                    if (showtimes != null && !showtimes.isEmpty()) {
                        for (Showtime s : showtimes) {
                    %>
                        <label>
                            <input type="radio" name="show_<%=m.getMovieId()%>" value="<%=s.getShowId()%>">
                            <%=s.getShowTime()%> | <%=s.getTheatre()%>
                        </label><br>
                    <%
                        }
                    } else {
                    %>
                        <span>No showtimes available</span>
                    <%
                    }
                    %>
                </div>

              
                <button class="book-btn" onclick="bookTicket(<%=m.getMovieId()%>)">Book</button>
            </div>
        </div>
        <%
        }
        } else {
        %>
        <p>No movies available at the moment.</p>
        <%
        }
        %>
    </div>
</section>

</body>
</html>
