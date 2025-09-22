<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,com.mvc.dao.BookingDAO,com.mvc.dao.MoviesDAO,com.mvc.dao.ShowtimeDAO,com.mvc.bean.Movie,com.mvc.bean.Showtime,com.mvc.bean.User" %>
<%@ include file="header.jsp"%>
<%
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    int showId = Integer.parseInt(request.getParameter("showId"));

    MoviesDAO movieDAO = new MoviesDAO();
    ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    BookingDAO bookingDAO = new BookingDAO();

    Movie movie = movieDAO.getMovieById(movieId);
    Showtime showtime = showtimeDAO.getShowtimeById(showId);
    User loggedUser = (User) session.getAttribute("User");
    if (loggedUser == null) {
        response.sendRedirect("loginForm.jsp?redirect=" + request.getRequestURI());
        return;
    }
    // Already booked seats
    List<String> bookedSeats = bookingDAO.getBookedSeats(showId);
    Set<String> bookedSet = new HashSet<>(bookedSeats);

    // Handle booking
    String[] selectedSeats = request.getParameterValues("seats");
    if (selectedSeats != null && selectedSeats.length > 0) {
        User currentUser = (User) session.getAttribute("User");
        if (currentUser != null) {
            boolean booked = bookingDAO.createBooking(currentUser.getUserId(), showId, selectedSeats);
            if (booked) {
                
                response.sendRedirect("mytickets.jsp");
                return;
            } else {
%>
                <script>alert("❌ Booking failed. Please try again.");</script>
<%
            }
        } else {
%>
            <script>
                alert("⚠️ You must be logged in to book tickets.");
                window.location.href = "loginForm.jsp?redirect=booking&movieId=<%= movieId %>&showId=<%= showId %>";
            </script>
<%
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Seats - <%= movie.getTitle() %></title>
    <link rel="stylesheet" href="style.css">
    <style>
        .seat input[type="checkbox"] { display: none; }
        .seat label { display:block; padding:5px; background:#ddd;color:black; border-radius:5px; text-align:center; cursor:pointer; }
        .seat input[type="checkbox"]:checked + label { background:green; color:black; }
        .seat label.booked { background:red; color:black; cursor:not-allowed; }
        .screen { text-align:center; background:#333; color:white; padding:5px; margin-bottom:20px; }
    </style>
</head>
<body>

<h2>Book Seats for <%= movie.getTitle() %></h2>
<p><strong>Theatre:</strong> <%= showtime.getTheatre() %></p>
<p><strong>Date:</strong> <%= showtime.getShowDate() %></p>
<p><strong>Time:</strong> <%= showtime.getShowTime() %></p>
<p><strong>Available Seats:</strong> <%= (showtime.getTotalSeats() - bookedSet.size()) %></p>

<div class="screen">SCREEN THIS WAY</div>

<form action="booking.jsp" method="post">
    <input type="hidden" name="movieId" value="<%= movieId %>">
    <input type="hidden" name="showId" value="<%= showId %>">

    <div class="seat-grid">
        <%
            char rowLetter = 'A';
            int totalSeats = showtime.getTotalSeats();
            int seatsPerRow = 10;
            int rows = (int) Math.ceil(totalSeats / (double) seatsPerRow);

            for (int row = 0; row < rows; row++) {
                for (int col = 1; col <= seatsPerRow; col++) {
                    int seatNumber = (row * seatsPerRow) + col;
                    if (seatNumber > totalSeats) break;
                    String seatId = rowLetter + String.valueOf(col);
                    boolean isBooked = bookedSet.contains(seatId);
        %>
            <div class="seat">
                <input type="checkbox" id="<%=seatId%>" name="seats" value="<%=seatId%>" <%= isBooked ? "disabled" : "" %>>
                <label for="<%=seatId%>" class="<%= isBooked ? "booked" : "" %>"><%=seatId%></label>
            </div>
        <%
                }
                rowLetter++;
            }
        %>
    </div>

    <!-- Center only the button -->
    <div class="confirm-container">
        <button type="submit" class="confirm-btn">Confirm Booking</button>
    </div>
</form>


</body>
</html>
