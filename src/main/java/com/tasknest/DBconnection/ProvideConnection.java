package com.tasknest.DBconnection;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ProvideConnection {
	
	  private static Connection con = null;
      
	  public static Connection giveusConnection() {
		  try {
	            // Load MySQL driver
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            // Load config.properties from WEB-INF/classes
	            InputStream input = ProvideConnection.class.getClassLoader().getResourceAsStream("config.properties");
	            if (input == null) {
	                throw new IOException("⚠ config.properties not found in WEB-INF/classes!");
	            }

	            Properties props = new Properties();
	            props.load(input);

	            String url = props.getProperty("db.url");
	            String username = props.getProperty("db.username");
	            String password = props.getProperty("db.password");

	            // Establish connection
	            con = DriverManager.getConnection(url, username, password);
	            System.out.println("✅ Database connection established successfully!");

	        } catch (ClassNotFoundException e) {
	            System.out.println("❌ MySQL Driver not found!");
	            e.printStackTrace();
	        } catch (SQLException e) {
	            System.out.println("❌ SQL error while connecting to database!");
	            e.printStackTrace();
	        } catch (IOException e) {
	            System.out.println("❌ Error reading config.properties!");
	            e.printStackTrace();
	        } catch (Exception e) {
	            System.out.println("❌ Unexpected error in DB connection!");
	            e.printStackTrace();
	        }
		  
		  return con;
		  
	  }
    
	}
