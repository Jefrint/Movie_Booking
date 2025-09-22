Movie Booking Website

A simple Movie Ticket Booking Website built using JSP (Java Server Pages), Servlets, and JDBC.
This project allows users to browse movies, select show timings, and book tickets online.

Features

User can view available movies.

Select movie, showtime, and number of seats.

Book tickets with a confirmation page.

Admin can add or manage movies .

Simple session management for user login/logout.

Tech Stack

Frontend: JSP, HTML, CSS
Backend: Java, Servlets, JSP
Database: MySQL (or your DB)
Server: Apache Tomcat

Installation & Setup

Clone the repository

git clone https://github.com/your-username/movie-booking-jsp.git
Import the project in Eclipse/IntelliJ
Select Import > Existing Projects into Workspace
Choose the cloned folder
Configure Database
Create a database (e.g., movie_booking) in MySQL
Import the SQL file provided in /db folder
Update your DB credentials in DBConnection.java
Run on Tomcat
Add project to Apache Tomcat server
Start server and open:
http://localhost:8080/movie-booking/
