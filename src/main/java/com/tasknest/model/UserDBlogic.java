package com.tasknest.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.tasknest.DBconnection.ProvideConnection;

public class UserDBlogic {
    public static boolean userExists(String email, String username) throws ClassNotFoundException, SQLException {
        try (Connection con = ProvideConnection.giveusConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT * FROM tasknest_users WHERE email = ? OR username = ?")) {

            ps.setString(1, email);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();

            boolean exists = rs.next();
            System.out.println("User exists check: " + exists);
            return exists;
        }
    }

    public static boolean createClientAccount(String fullname, String email, String username, String password, String role)
            throws ClassNotFoundException, SQLException {

        try (Connection con = ProvideConnection.giveusConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO tasknest_users (fullname, email, username, password, role) VALUES (?, ?, ?, ?, ?)")) {

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, role);

            int rowsInserted = ps.executeUpdate();
            System.out.println("Insert result: " + rowsInserted);
            return rowsInserted > 0;
        }
    }
    public static AccountUser login(String email,String password) throws SQLException, ClassNotFoundException {
    	 try (Connection con = ProvideConnection.giveusConnection();
    	         PreparedStatement ps = con.prepareStatement(
    	             "SELECT * FROM tasknest_users WHERE email = ? AND password = ?")) {

    	        ps.setString(1, email);
    	        ps.setString(2, password);
    	        ResultSet rs = ps.executeQuery();

    	        if (rs.next()) {
    	        	int id = rs.getInt("id");
    	            String fullname = rs.getString("fullname");
    	            String email1 = rs.getString("email");
    	            String role = rs.getString("role");
    	            String username1=rs.getString("username");
    	            String password1=rs.getString("password");
    	            
    	            
    	            AccountUser a1=new AccountUser();
    	            a1.setId(id);
    	            a1.setFullname(fullname);
    	            a1.setEmail(email1);
    	            a1.setUsername(username1);
    	            a1.setPassword(password1);
    	            a1.setRole(role);
    	            return a1;
    	        } else {
    	            return null;
    	        }
    	    }
  }
    
    public static boolean insertProject(String clientName, String title, String description, double budget, String deadline, String category) {
        boolean success = false;

        try {
            Connection con=ProvideConnection.giveusConnection();

            String sql = "INSERT INTO projects (client_name, title, description, budget, deadline, category, posted_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, clientName);
            stmt.setString(2, title);
            stmt.setString(3, description);
            stmt.setDouble(4, budget);
            stmt.setString(5, deadline);
            stmt.setString(6, category);

            int rows = stmt.executeUpdate();
            success = rows > 0;

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public static List<Map<String, String>> getProjectsByClient(String clientName) {
        List<Map<String, String>> projects = new ArrayList<>();

        try {
            Connection conn=ProvideConnection.giveusConnection();

            String sql = "SELECT id, title, description, budget, deadline, category, posted_at FROM projects WHERE client_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, clientName);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> project = new HashMap<>();
                project.put("id", rs.getString("id"));
                project.put("title", rs.getString("title"));
                project.put("description", rs.getString("description"));
                project.put("budget", rs.getString("budget"));
                project.put("deadline", rs.getString("deadline"));
                project.put("category", rs.getString("category"));
                project.put("posted_at", rs.getString("posted_at"));
                projects.add(project);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return projects;
    }
   
    
    public static boolean deleteProjectById(String projectId, String clientName) {
        boolean success = false;

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "DELETE FROM projects WHERE id = ? AND client_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, projectId);
            stmt.setString(2, clientName);

            int rows = stmt.executeUpdate();
            success = rows > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public static boolean updateProject(String id, String clientName, String title, String description, double budget, String deadline, String category) {
        boolean success = false;

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "UPDATE projects SET title = ?, description = ?, budget = ?, deadline = ?, category = ? WHERE id = ? AND client_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setDouble(3, budget);
            stmt.setString(4, deadline);
            stmt.setString(5, category);
            stmt.setString(6, id);
            stmt.setString(7, clientName);

            int rows = stmt.executeUpdate();
            success = rows > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public static Map<String, String> getProjectById(String id, String clientName) {
        Map<String, String> project = new HashMap<>();

        try {
            Connection conn =ProvideConnection.giveusConnection();
            
            System.out.println("Looking for project ID: " + id + " with client: " + clientName);
            String sql = "SELECT * FROM projects WHERE id = ? AND client_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            stmt.setString(2, clientName);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                project.put("id", rs.getString("id"));
                project.put("title", rs.getString("title"));
                project.put("description", rs.getString("description"));
                project.put("budget", rs.getString("budget"));
                project.put("deadline", rs.getString("deadline"));
                project.put("category", rs.getString("category"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return project;
    }
    
    public static List<Map<String, String>> getAllProjects() {
        List<Map<String, String>> projects = new ArrayList<>();

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "SELECT * FROM projects ORDER BY posted_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, String> project = new HashMap<>();
                project.put("id", rs.getString("id"));
                project.put("title", rs.getString("title"));
                project.put("description", rs.getString("description"));
                project.put("budget", rs.getString("budget"));
                project.put("deadline", rs.getString("deadline"));
                project.put("category", rs.getString("category"));
                project.put("posted_at", rs.getString("posted_at"));
                project.put("client_name", rs.getString("client_name"));
                projects.add(project);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return projects;
    }
    
    
    public static Map<String, String> getProjectById1(String id) {
        Map<String, String> project = new HashMap<>();

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "SELECT * FROM projects WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                project.put("id", rs.getString("id"));
                project.put("title", rs.getString("title"));
                project.put("description", rs.getString("description"));
                project.put("budget", rs.getString("budget"));
                project.put("deadline", rs.getString("deadline"));
                project.put("category", rs.getString("category"));
                project.put("client_name", rs.getString("client_name"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return project;
    }
    
    public static boolean submitApplication(String projectId, String clientName, String freelancerName, String proposal, double expectedBudget, int estimatedDays) {
        boolean success = false;

        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "INSERT INTO applications (project_id, client_name, freelancer_name, proposal, expected_budget, estimated_days, applied_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, projectId);
            stmt.setString(2, clientName);
            stmt.setString(3, freelancerName);
            stmt.setString(4, proposal);
            stmt.setDouble(5, expectedBudget);
            stmt.setInt(6, estimatedDays);

            int rows = stmt.executeUpdate();
            success = rows > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public static List<Map<String, String>> getApplicationsByProjectId(String projectId) {
        List<Map<String, String>> applications = new ArrayList<>();

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "SELECT * FROM applications WHERE project_id = ? ORDER BY applied_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, projectId);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> app = new HashMap<>();
                app.put("project_id", rs.getString("project_id"));
                app.put("freelancer_name", rs.getString("freelancer_name"));
                app.put("proposal", rs.getString("proposal"));
                app.put("expected_budget", rs.getString("expected_budget"));
                app.put("estimated_days", rs.getString("estimated_days"));
                app.put("applied_at", rs.getString("applied_at"));
                applications.add(app);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }
    
    public static List<Map<String, String>> getProjectAnalytics(String clientName) {
        List<Map<String, String>> analytics = new ArrayList<>();

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "SELECT project_id, COUNT(*) AS total_applications, " +
                         "AVG(expected_budget) AS avg_budget, AVG(estimated_days) AS avg_days " +
                         "FROM applications WHERE client_name = ? GROUP BY project_id";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, clientName);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> data = new HashMap<>();
                data.put("project_id", rs.getString("project_id"));
                data.put("total_applications", rs.getString("total_applications"));
                data.put("avg_budget", rs.getString("avg_budget"));
                data.put("avg_days", rs.getString("avg_days"));
                analytics.add(data);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return analytics;
    }
    
    public static void sendMessage(String sender, String receiver, String projectId, String message) {
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "INSERT INTO messages (sender, receiver, project_id, message) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, sender);
            stmt.setString(2, receiver);
            stmt.setString(3, projectId);
            stmt.setString(4, message);
            stmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public static List<Map<String, String>> getMessages(String clientName) {
        List<Map<String, String>> messages = new ArrayList<>();
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "SELECT * FROM messages WHERE sender = ? OR receiver = ? ORDER BY sent_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, clientName);
            stmt.setString(2, clientName);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> msg = new HashMap<>();
                msg.put("sender", rs.getString("sender"));
                msg.put("receiver", rs.getString("receiver"));
                msg.put("project_id", rs.getString("project_id"));
                msg.put("message", rs.getString("message"));
                msg.put("sent_at", rs.getString("sent_at"));
                messages.add(msg);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return messages;
    }
    
    
    public static List<Map<String, String>> getApplicationsByClient(String clientName) {
        List<Map<String, String>> applications = new ArrayList<>();

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "SELECT a.project_id, a.freelancer_name, a.proposal, a.expected_budget, a.estimated_days, a.applied_at " +
                         "FROM applications a " +
                         "JOIN projects p ON a.project_id = p.id " +
                         "WHERE p.client_name = ? " +
                         "ORDER BY a.applied_at DESC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, clientName);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> app = new HashMap<>();
                app.put("project_id", rs.getString("project_id"));
                app.put("freelancer_name", rs.getString("freelancer_name"));
                app.put("proposal", rs.getString("proposal"));
                app.put("expected_budget", rs.getString("expected_budget"));
                app.put("estimated_days", rs.getString("estimated_days"));
                app.put("applied_at", rs.getString("applied_at"));
                applications.add(app);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }
    
    public static List<Map<String, String>> getApplicationsByFreelancer(String freelancerName) {
        List<Map<String, String>> applications = new ArrayList<>();

        try {
            Connection conn = ProvideConnection.giveusConnection();

            String sql = "SELECT a.project_id, p.title, p.description, a.expected_budget, a.estimated_days, a.applied_at " +
                         "FROM applications a " +
                         "JOIN projects p ON a.project_id = p.id " +
                         "WHERE a.freelancer_name = ? " +
                         "ORDER BY a.applied_at DESC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, freelancerName);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> app = new HashMap<>();
                app.put("project_id", rs.getString("project_id"));
                app.put("title", rs.getString("title"));
                app.put("description", rs.getString("description"));
                app.put("expected_budget", rs.getString("expected_budget"));
                app.put("estimated_days", rs.getString("estimated_days"));
                app.put("applied_at", rs.getString("applied_at"));
                applications.add(app);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }
    
    public static Map<String, String> getFreelancerProfile(String name) {
        Map<String, String> profile = new HashMap<>();

        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "SELECT fullname, email, skills, bio FROM freelancers WHERE fullname = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                profile.put("fullname", rs.getString("fullname"));
                profile.put("email", rs.getString("email"));
                profile.put("skills", rs.getString("skills"));
                profile.put("bio", rs.getString("bio"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return profile;
    }

    
    
    public static void saveOrUpdateFreelancerProfile(String name, String email, String skills, String bio) {
        try {
            Connection conn = ProvideConnection.giveusConnection();

            String checkSql = "SELECT COUNT(*) FROM freelancers WHERE fullname = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, name);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            boolean exists = rs.getInt(1) > 0;

            if (exists) {
                String updateSql = "UPDATE freelancers SET email = ?, skills = ?, bio = ? WHERE fullname = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, email);
                updateStmt.setString(2, skills);
                updateStmt.setString(3, bio);
                updateStmt.setString(5, name);
                updateStmt.executeUpdate();
            } else {
                String insertSql = "INSERT INTO freelancers (fullname, email, skills, bio) VALUES (?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, name);
                insertStmt.setString(2, email);
                insertStmt.setString(3, skills);
                insertStmt.setString(4, bio);
                insertStmt.executeUpdate();
            }
            
            System.out.println("Email: " + email);
            System.out.println("Skills: " + skills);
            System.out.println("Bio: " + bio);

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void saveProject(String freelancer, int projectId) {
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "INSERT INTO saved_projects (freelancer_name, project_id) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, freelancer);
            stmt.setInt(2, projectId);
            stmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static List<Map<String, String>> getSavedProjects(String freelancerName) {
        List<Map<String, String>> savedProjects = new ArrayList<>();
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "SELECT p.id, p.title, p.description, p.category, p.budget, p.deadline, p.posted_at " +
                         "FROM saved_projects sp " +
                         "JOIN projects p ON sp.project_id = p.id " +
                         "WHERE sp.freelancer_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, freelancerName);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, String> project = new HashMap<>();
                project.put("id", rs.getString("id"));
                project.put("title", rs.getString("title"));
                project.put("description", rs.getString("description"));
                project.put("category", rs.getString("category"));
                project.put("budget", rs.getString("budget"));
                project.put("deadline", rs.getString("deadline"));
                project.put("posted_at", rs.getString("posted_at"));
                savedProjects.add(project);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return savedProjects;
    }
    
    public static void unsaveProject(String freelancer, int projectId) {
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "DELETE FROM saved_projects WHERE freelancer_name = ? AND project_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, freelancer);
            stmt.setInt(2, projectId);
            stmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } 
    
    public static boolean assignProject(String projectId, String freelancerName) {
        boolean status = false;
        try {
            Connection conn = ProvideConnection.giveusConnection();
            String sql = "INSERT INTO assigned_projects (project_id, freelancer_name) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(projectId));
            ps.setString(2, freelancerName);
            status = ps.executeUpdate() > 0;
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
  
    
    
}

