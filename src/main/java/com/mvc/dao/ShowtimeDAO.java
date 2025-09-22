package com.mvc.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.mvc.bean.Showtime;

public class ShowtimeDAO {

	

	public List<Showtime> getAllShowtimes() {
		List<Showtime> showtimes = new ArrayList<>();
		String sql = "SELECT * FROM Showtime";

		try {
			DBDAO.connect();

			Connection conn = DBDAO.getDbCon();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Showtime show = new Showtime();
				show.setShowId(rs.getInt("show_id"));
				show.setMovieId(rs.getInt("movie_id"));
				show.setTheatre(rs.getString("theatre"));
				show.setShowDate(rs.getDate("show_date"));
				show.setShowTime(rs.getString("show_time"));
				show.setTotalSeats(rs.getInt("total_seats"));
				show.setBookedSeats(rs.getInt("booked_seats"));

				showtimes.add(show);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return showtimes;
	}

	public List<Showtime> getShowtimesByMovieId(int movieId) {
		List<Showtime> showtimes = new ArrayList<>();
		String sql = "SELECT * FROM Showtime WHERE movie_id = ?";

		try {
			DBDAO.connect();

			Connection conn = DBDAO.getDbCon();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, movieId);
			ResultSet rs = ps.executeQuery();

			

			while (rs.next()) {
				Showtime show = new Showtime();
				show.setShowId(rs.getInt("show_id"));
				show.setMovieId(rs.getInt("movie_id"));
				show.setTheatre(rs.getString("theatre"));
				show.setShowDate(rs.getDate("show_date"));
				show.setShowTime(rs.getString("show_time"));
				show.setTotalSeats(rs.getInt("total_seats"));
				show.setBookedSeats(rs.getInt("booked_seats"));
				showtimes.add(show);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return showtimes;
	}
	 public Showtime getShowtimeById(int showId) {
	        Showtime show = null;
	        try {
	            Connection con = DBDAO.getDbCon();
	            DBDAO.connect();
	            
	            PreparedStatement ps = con.prepareStatement("SELECT * FROM Showtime WHERE show_id = ?");
	            ps.setInt(1, showId);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                show = new Showtime();
	                show.setShowId(rs.getInt("show_id"));
	                show.setMovieId(rs.getInt("movie_id"));
	                show.setTheatre(rs.getString("theatre"));
	                show.setShowDate(rs.getDate("show_date"));
	                show.setShowTime(rs.getString("show_time"));
	                show.setTotalSeats(rs.getInt("total_seats"));
	                show.setBookedSeats(rs.getInt("booked_seats"));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return show;
	    }

	 public void addShowtime(int movieId, String theatre, Date showDate,
	                         String showTime, int totalSeats, int bookedSeats) {
	     String sql = "INSERT INTO Showtime (movie_id, theatre, show_date, show_time, total_seats, booked_seats) " +
	                  "VALUES (?, ?, ?, ?, ?, ?)";

	     try {
	         // Ensure DB connection is active
	         if (DBDAO.getDbCon() == null || DBDAO.getDbCon().isClosed()) {
	             DBDAO.connect();
	         }

	         Connection conn = DBDAO.getDbCon();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ps.setInt(1, movieId);
	         ps.setString(2, theatre);
	         ps.setDate(3, showDate);  // java.sql.Date expected
	         ps.setString(4, showTime);
	         ps.setInt(5, totalSeats);
	         ps.setInt(6, bookedSeats);

	         ps.executeUpdate();
	         ps.close();
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	 }
	 
	// ShowtimeDAO.java

	 public boolean updateShowtime(int showId, int movieId, String theatre, Date showDate, String showTime, int totalSeats) {
	     String sql = "UPDATE Showtime SET movie_id=?, theatre=?, show_date=?, show_time=?, total_seats=? WHERE show_id=?";
	     try {
	         Connection conn = DBDAO.getDbCon();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ps.setInt(1, movieId);
	         ps.setString(2, theatre);
	         ps.setDate(3, showDate);
	         ps.setString(4, showTime);
	         ps.setInt(5, totalSeats);
	         ps.setInt(6, showId);
	         int rows = ps.executeUpdate();
	         ps.close();
	         return rows > 0;
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	     return false;
	 }

	 public boolean deleteShowtime(int showId) {
	     String sql = "DELETE FROM Showtime WHERE show_id=?";
	     try {
	         Connection conn = DBDAO.getDbCon();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ps.setInt(1, showId);
	         int rows = ps.executeUpdate();
	         ps.close();
	         return rows > 0;
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	     return false;
	 }


	 

}
