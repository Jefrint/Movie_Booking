package com.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.mvc.bean.Booking;

public class BookingDAO {
	  public boolean createBooking(int userId, int showId, String[] seats) {
	        boolean success = false;
	        try {
	            Connection con = DBDAO.getDbCon();
	            DBDAO.connect();

	            String seatString = String.join(",", seats);
	            String sql = "INSERT INTO Booking(user_id, show_id, seats, status) VALUES (?, ?, ?, 'Confirmed')";
	            PreparedStatement ps = con.prepareStatement(sql);

	            ps.setInt(1, userId);
	            ps.setInt(2, showId);
	            ps.setString(3, seatString);

	            int rows = ps.executeUpdate();

	            if (rows > 0) {
	                // update booked seat count in Showtime
	                String update = "UPDATE Showtime SET booked_seats = booked_seats + ? WHERE show_id = ?";
	                PreparedStatement ps2 = con.prepareStatement(update);
	                ps2.setInt(1, seats.length);
	                ps2.setInt(2, showId);
	                ps2.executeUpdate();
	                ps2.close();

	                success = true;
	            }

	            ps.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return success;
	    }
	  public List<String> getBookedSeats(int showId) {
	        List<String> bookedSeats = new ArrayList<>();
	        try {
	            Connection con = DBDAO.getDbCon();
	            DBDAO.connect();

	            String sql = "SELECT seats FROM Booking WHERE show_id = ? AND status = 'Confirmed'";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setInt(1, showId);

	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                String seatStr = rs.getString("seats");
	                if (seatStr != null && !seatStr.isEmpty()) {
	                    bookedSeats.addAll(Arrays.asList(seatStr.split(",")));
	                }
	            }

	            rs.close();
	            ps.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return bookedSeats;
	    }
	   public boolean updateBookedSeats(int showId, int newBookedSeats) {
	        boolean success = false;
	        try {
	            Connection con = DBDAO.getDbCon();
	            DBDAO.connect();
	            String sql = "UPDATE Showtime SET booked_seats = ? WHERE show_id = ?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setInt(1, newBookedSeats);
	            ps.setInt(2, showId);
	            int rows = ps.executeUpdate();
	            if (rows > 0) {
	                success = true;
	            }
	            ps.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return success;
	    }
	   
	   public List<Booking> getBookingsByUserId(int userId) {
		    List<Booking> bookings = new ArrayList<>();
		    String sql = "SELECT * FROM Booking WHERE user_id = ?";

		    try {
		        Connection conn = DBDAO.getDbCon();
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setInt(1, userId);
		        ResultSet rs = ps.executeQuery();

		        while (rs.next()) {
		            Booking booking = new Booking();
		            booking.setBookingId(rs.getInt("booking_id"));
		            booking.setUserId(rs.getInt("user_id"));
		            booking.setShowId(rs.getInt("show_id"));
		            booking.setSeats(rs.getString("seats"));
		            booking.setStatus(rs.getString("status"));
		            bookings.add(booking);
		        }

		        rs.close();
		        ps.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return bookings;
		}

	   
}
