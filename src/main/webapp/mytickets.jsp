<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,com.mvc.dao.BookingDAO,com.mvc.dao.ShowtimeDAO,com.mvc.dao.MoviesDAO,com.mvc.bean.Booking,com.mvc.bean.Showtime,com.mvc.bean.Movie,com.mvc.bean.User" %>

<%
    User loggedUser = (User) session.getAttribute("User");
    if (loggedUser == null) {
        response.sendRedirect("loginForm.jsp?redirect=mytickets");
        return;
    }

    BookingDAO bookingDAO = new BookingDAO();
    ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    MoviesDAO movieDAO = new MoviesDAO();
    
    List<Booking> bookings = bookingDAO.getBookingsByUserId(loggedUser.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Tickets - Movie Booking</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="myticket-container">
    <h2 style={color:black}>🎟 My Tickets</h2>

    <%
        if (bookings == null || bookings.isEmpty()) {
    %>
        <p class="no-tickets">You haven’t booked any tickets yet.</p>
    <%
        } else {
            for (Booking booking : bookings) {
                Showtime showtime = showtimeDAO.getShowtimeById(booking.getShowId());
                Movie movie = movieDAO.getMovieById(showtime.getMovieId());
    %>
        <div class="ticket-card">
            <div class="ticket-header">
                <h3><%= movie.getTitle() %></h3>
                <span class="status <%= booking.getStatus().toLowerCase() %>"><%= booking.getStatus() %></span>
            </div>
            <div class="ticket-body">
                <p><strong>Theatre:</strong> <%= showtime.getTheatre() %></p>
                <p><strong>Date:</strong> <%= showtime.getShowDate() %></p>
                <p><strong>Time:</strong> <%= showtime.getShowTime() %></p>
                <p><strong>Seats:</strong> <%= booking.getSeats() %></p>
            </div>
        </div>
    <%
            }
        }
    %>
</div>

</body>
</html>
