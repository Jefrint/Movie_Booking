package com.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;

import com.mvc.bean.User;

public class UserDAO {
	


    public boolean registerUser(User user) {
        boolean status = false;
        String sql = "INSERT INTO user(username, password, email, user_type) VALUES (?, ?, ?, ?)";

        try {
        	DBDAO.connect() ;
            if (DBDAO.getDbCon() == null || DBDAO.getDbCon().isClosed()) {
                System.out.println("DBDAO.getDbCon()=null");
            }

            Connection conn = DBDAO.getDbCon();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getUserType());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }

            ps.close();

        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("⚠️ Email already exists: " + user.getEmail());
            status = false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    
    public User LoginUser(String email,String password) {
        User loggedUser = null;
    	 String sql="Select * from user where email=? and password=?";
    	 try {
    		 DBDAO.connect() ;
    		  if (DBDAO.getDbCon() == null || DBDAO.getDbCon().isClosed()) {
                  System.out.println("DBDAO.getDbCon()=null");
              }
    		 
    		  Connection conn = DBDAO.getDbCon();
              PreparedStatement ps = conn.prepareStatement(sql);
              ps.setString(1,email);
              ps.setString(2, password);

              ResultSet rs = ps.executeQuery();
              if (rs.next()) {
                  loggedUser = new User();
                  loggedUser.setUserId(rs.getInt("user_id"));
                  loggedUser.setUsername(rs.getString("username"));
                  loggedUser.setEmail(rs.getString("email"));
                  loggedUser.setPassword(rs.getString("password")); 
                  loggedUser.setUserType(rs.getString("user_type"));
              }
              rs.close();
              ps.close();
              
    		 
    	 }catch (SQLIntegrityConstraintViolationException e) {
             System.out.println("⚠️ Failed to Login.: " + email);
             
         } catch (Exception e) {
             e.printStackTrace();
         }
    	 
    	 
		return loggedUser;
    }
    	
    
}
