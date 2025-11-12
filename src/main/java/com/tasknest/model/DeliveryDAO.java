package com.tasknest.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.tasknest.DBconnection.ProvideConnection;

public class DeliveryDAO {
	  public static boolean submitDelivery(int projectId, int freelancerId, String note, String filePath, String linkUrl) {
		    boolean status = false;
		    try {
		      Connection conn = ProvideConnection.giveusConnection();
		      String query = "INSERT INTO project_delivery (project_id, freelancer_id, delivery_note, file_path, link_url) VALUES (?, ?, ?, ?, ?)";
		      PreparedStatement ps = conn.prepareStatement(query);
		      ps.setInt(1, projectId);
		      ps.setInt(2, freelancerId);
		      ps.setString(3, note);
		      ps.setString(4, filePath);
		      ps.setString(5, linkUrl);

		      int rows = ps.executeUpdate();
		      status = rows > 0;
		      conn.close();
		    } catch (SQLException e) {
		      e.printStackTrace();
		    }
		    return status;
		  }


}
