package com.mvc.bean;


public class Movie {
	 private int movieId;
	    private String title;
	    private String genre;
	    private String language;
	    private String duration;
	    private String description;
	    private double rating; 
	    private String url;

    public Movie() {}

   

  
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    
    public String getURL() { return url; }
    public void setURL(String url) { this.url = url; }

   
}
