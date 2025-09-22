package com.mvc.dao;

import com.mvc.bean.Movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MoviesDAO {
	public List<Movie> getAllMovies() {
		List<Movie> movies = new ArrayList<>();
		String sql = "SELECT * FROM Movie";

		try {
			// Ensure DB connection is active
			if (DBDAO.getDbCon() == null || DBDAO.getDbCon().isClosed()) {
				DBDAO.connect();
			}

			Connection conn = DBDAO.getDbCon();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Movie movie = new Movie();
				movie.setMovieId(rs.getInt("movie_id"));
				movie.setTitle(rs.getString("title"));
				movie.setGenre(rs.getString("genre"));
				movie.setLanguage(rs.getString("language"));
				movie.setDuration(rs.getString("duration"));
				movie.setDescription(rs.getString("description"));
				movie.setRating(rs.getDouble("rating"));
				movie.setURL(rs.getString("url"));
				movies.add(movie);
			}

			rs.close();
			ps.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return movies;
	}

	public Movie getMovieById(int movieId) {
		Movie movie = null;
		String sql = "SELECT * FROM Movie WHERE movie_id = ?";

		try {
			// Ensure DB connection is active
			if (DBDAO.getDbCon() == null || DBDAO.getDbCon().isClosed()) {
				DBDAO.connect();
			}

			Connection conn = DBDAO.getDbCon();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, movieId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				movie = new Movie();
				movie.setMovieId(rs.getInt("movie_id"));
				movie.setTitle(rs.getString("title"));
				movie.setGenre(rs.getString("genre"));
				movie.setLanguage(rs.getString("language"));
				movie.setDuration(rs.getString("duration"));
				movie.setDescription(rs.getString("description"));
				movie.setRating(rs.getDouble("rating"));
				movie.setURL(rs.getString("url"));
			}

			rs.close();
			ps.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return movie;
	}

	public void addMovie(String title, String genre, String language, String duration, String description,
			double rating, String url) {
		String sql = "INSERT INTO Movie (title, genre, language, duration, description, rating, url) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

		try {
			if (DBDAO.getDbCon() == null || DBDAO.getDbCon().isClosed()) {
				DBDAO.connect();
			}

			Connection conn = DBDAO.getDbCon();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, title);
			ps.setString(2, genre);
			ps.setString(3, language);
			ps.setString(4, duration);
			ps.setString(5, description);
			ps.setDouble(6, rating);
			ps.setString(7, url);

			ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// MoviesDAO.java

	public boolean updateMovie(int movieId, String title, String genre, String language, String duration, String description, double rating, String url) {
	    String sql = "UPDATE Movie SET title=?, genre=?, language=?, duration=?, description=?, rating=?, url=? WHERE movie_id=?";
	    try {
	        Connection conn = DBDAO.getDbCon();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, title);
	        ps.setString(2, genre);
	        ps.setString(3, language);
	        ps.setString(4, duration);
	        ps.setString(5, description);
	        ps.setDouble(6, rating);
	        ps.setString(7, url);
	        ps.setInt(8, movieId);
	        int rows = ps.executeUpdate();
	        ps.close();
	        return rows > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	public boolean deleteMovie(int movieId) {
	    String sql = "DELETE FROM Movie WHERE movie_id=?";
	    try {
	        Connection conn = DBDAO.getDbCon();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, movieId);
	        int rows = ps.executeUpdate();
	        ps.close();
	        return rows > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}


}
