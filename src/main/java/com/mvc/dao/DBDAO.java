package com.mvc.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBDAO {

	private static Connection dbCon;

	private static String dbDriver;
	private static String dbURL;
	private static String userName;
	private static String passWord;


	private static void dbInit() {
		
			dbDriver = "com.mysql.cj.jdbc.Driver";  
			dbURL = "jdbc:mysql://172.30.1.123:3306/movies_booking";
			userName = "root";
			passWord = "Devteamtraining2025$";
	}

	
	public static void connect() throws ClassNotFoundException, SQLException {
		dbInit();
		Connection conn = null;
		try {
			Class.forName(dbDriver);
			conn = DriverManager.getConnection(dbURL, userName, passWord);
			setDbCon(conn);
		

		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		} catch (SQLException sql) {
			sql.printStackTrace();
		}
	}


	public static void setDbCon(Connection con) {
		
		dbCon = con;
	}

	public static Connection getDbCon() {
		return dbCon;
	}
	

	public static void dbClose() throws SQLException {
		dbCon.close();
	}


}
