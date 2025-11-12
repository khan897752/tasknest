package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class SaveProjectServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String freelancer = req.getParameter("freelancer_name");
		 int projectId = Integer.parseInt(req.getParameter("project_id"));
		 
		 
		 UserDBlogic.saveProject(freelancer, projectId);
		 
	        resp.sendRedirect("BrowseProjects.jsp?success=Project saved");

	}

}
