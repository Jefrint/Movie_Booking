package com.mvc.bean;

import java.sql.Date;

public class Showtime {
    private int showId;
    private int movieId;
    private String theatre;
    private Date showDate;
    private String showTime;
    private int totalSeats;
    private int bookedSeats;

    // Getters and Setters
    public int getShowId() { return showId; }
    public void setShowId(int showId) { this.showId = showId; }

    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTheatre() { return theatre; }
    public void setTheatre(String theatre) { this.theatre = theatre; }

    public Date getShowDate() { return showDate; }
    public void setShowDate(Date showDate) { this.showDate = showDate; }

    public String getShowTime() { return showTime; }
    public void setShowTime(String showTime) { this.showTime = showTime; }

    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }

    public int getBookedSeats() { return bookedSeats; }
    public void setBookedSeats(int bookedSeats) { this.bookedSeats = bookedSeats; }
}
