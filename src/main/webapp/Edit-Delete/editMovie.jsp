<%@ page import="com.mvc.dao.MoviesDAO, com.mvc.bean.Movie" %>
<%@ include file="/header.jsp" %>

<%
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    MoviesDAO movieDAO = new MoviesDAO();
    Movie movie = movieDAO.getMovieById(movieId);

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        String language = request.getParameter("language");
        String duration = request.getParameter("duration");
        String description = request.getParameter("description");
        double rating = Double.parseDouble(request.getParameter("rating"));
        String url = request.getParameter("url");

        boolean updated = movieDAO.updateMovie(movieId, title, genre, language, duration, description, rating, url);
        if (updated) {
            response.sendRedirect(request.getContextPath() +"/admin.jsp");
        }
    }
%>

<div class="admin-container">

    <form method="post" action="editMovie.jsp?movieId=<%=movieId%>" class="admin-form">
        <h2>Edit Movie</h2>
        <label>Title</label>
        <input type="text" name="title" value="<%=movie.getTitle()%>" required>
        <label>Genre</label>
        <input type="text" name="genre" value="<%=movie.getGenre()%>" required>
        <label>Language</label>
        <input type="text" name="language" value="<%=movie.getLanguage()%>" required>
        <label>Duration</label>
        <input type="text" name="duration" value="<%=movie.getDuration()%>" required>
        <label>Description</label>
        <textarea name="description" rows="3" required><%=movie.getDescription()%></textarea>
        <label>Rating</label>
        <input type="number" name="rating" value="<%=movie.getRating()%>" min="0" max="10" step="0.1" required>
        <label>Poster URL</label>
        <input type="text" name="url" value="<%=movie.getURL()%>" required>
        <button type="submit" class="btn">Update Movie</button>
    </form>

</div>
