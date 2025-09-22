package com.mvc.bean;


public class Booking {
    private int bookingId;
    private int userId;
    private int showId;
    private String seats;
    private String status;

    public Booking() {}

    public Booking(int bookingId, int userId, int showId, String seats, String status) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.showId = showId;
        this.seats = seats;
        this.status = status;
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getShowId() { return showId; }
    public void setShowId(int showId) { this.showId = showId; }

    public String getSeats() { return seats; }
    public void setSeats(String seats) { this.seats = seats; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingId=" + bookingId +
                ", userId=" + userId +
                ", showId=" + showId +
                ", seats='" + seats + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
