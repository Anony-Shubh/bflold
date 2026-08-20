package pmegpgeotag.pmegpgeo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Dbconnect {
	
	    static String DB_DRIVER = "com.mysql.jdbc.Driver";
	    static String DB_CONNECTION = "jdbc:mysql://localhost:3306/test";
	    static String DB_USER = "userName";
	    static String DB_PASSWORD = "password";
	 
	   
	    
	    public void batchUpdateUsingPreparedStatement() throws SQLException, ClassNotFoundException {
	    	Connection connection = null;
	        Class.forName(DB_DRIVER);
	        connection = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);
	    	 
	        int[] result = null;
	        String SQL = "update person set firstName=?,lastName=? where id=?"; 
	        // '?' is the placeholder for the parameter
	        try {
	            PreparedStatement stmt = connection.prepareStatement(SQL);
	            connection.setAutoCommit(false);
	            stmt.setString(1, "Abc"); // Value for the first parameter, namely 'firstName'
	            stmt.setString(2, "Def"); // Value for the second parameter, namely 'lastName'
	            stmt.setInt(3, 1); // Value for the third parameter, namely 'id'
	            stmt.addBatch(); // Add to Batch
	     
	            stmt.setString(1, "Xyz");
	            stmt.setString(2, "Uvw");
	            stmt.setInt(3, 2);
	            stmt.addBatch(); // Add second query to the Batch
	            result = stmt.executeBatch(); // execute the Batch and commit
	            connection.commit();
	        } catch (SQLException e) {
	            connection.rollback();
	            e.printStackTrace();
	        } finally {
	            if (connection != null)
	                connection.close();
	        }
	        System.out.println("Number of rows affected: " + result.length);
	    }
	}


