package com.tasknest.model;

import com.tasknest.DBconnection.ProvideConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class AdminDBLogic {
	
	 public static String validateAdmin(String email, String password) {
	        String fullname = null;
	        try {
	            Connection conn = ProvideConnection.giveusConnection();
	            String sql = "SELECT fullname FROM tasknest_users WHERE email = ? AND password = ? AND role = 'admin'";
	            PreparedStatement stmt = conn.prepareStatement(sql);
	            stmt.setString(1, email);
	            stmt.setString(2, password);
	            ResultSet rs = stmt.executeQuery();

	            if (rs.next()) {
	                fullname = rs.getString("fullname");
	            }

	            conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return fullname;
	    }

	
    public static List<Map<String, String>> getAllUsers() {
        List<Map<String, String>> users = new ArrayList<>();
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "SELECT fullname, email, role FROM tasknest_users ORDER BY role";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, String> user = new HashMap<>();
                user.put("fullname", rs.getString("fullname"));
                user.put("email", rs.getString("email"));
                user.put("role", rs.getString("role"));
                users.add(user);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public static boolean deleteUserByEmail(String email) {
        boolean deleted = false;
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "DELETE FROM tasknest_users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            int rows = stmt.executeUpdate();
            deleted = rows > 0;
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deleted;
    }
    
    public static List<Map<String, String>> getAllProjects() {
        List<Map<String, String>> projects = new ArrayList<>();
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "SELECT id, title, category, budget, deadline FROM projects ORDER BY posted_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, String> project = new HashMap<>();
                project.put("id", rs.getString("id"));
                project.put("title", rs.getString("title"));
                project.put("category", rs.getString("category"));
                project.put("budget", rs.getString("budget"));
                project.put("deadline", rs.getString("deadline"));
                projects.add(project);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return projects;
    }
    
    public static boolean deleteProjectById(String projectId) {
        boolean deleted = false;
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "DELETE FROM projects WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, projectId);
            int rows = stmt.executeUpdate();
            deleted = rows > 0;
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deleted;
    }
    
    public static int getUserCount() {
        try (Connection conn = ProvideConnection.giveusConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM tasknest_users");
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static int getProjectCount() {
        try (Connection conn = ProvideConnection.giveusConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM projects");
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static int getMonthlySignups() {
        try (Connection conn = ProvideConnection.giveusConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT COUNT(*) FROM tasknest_users WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())");
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static double getAverageBudget() {
        try (Connection conn = ProvideConnection.giveusConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT AVG(budget) FROM projects");
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getDouble(1) : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }
    
    public static boolean saveContactMessage(String name, String email, String role, String message) {
        try (Connection conn = ProvideConnection.giveusConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "INSERT INTO contact_messages (name, email, role, message, submitted_at) VALUES (?, ?, ?, ?, NOW())")) {
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, role);
            stmt.setString(4, message);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static List<Map<String, String>> getAllContactMessages() {
        List<Map<String, String>> messages = new ArrayList<>();

        try (Connection conn = ProvideConnection.giveusConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM contact_messages ORDER BY submitted_at DESC");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, String> msg = new HashMap<>();
                msg.put("name", rs.getString("name"));
                msg.put("email", rs.getString("email"));
                msg.put("role", rs.getString("role"));
                msg.put("message", rs.getString("message"));
                msg.put("submitted_at", rs.getString("submitted_at"));
                messages.add(msg);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return messages;
    }




}
