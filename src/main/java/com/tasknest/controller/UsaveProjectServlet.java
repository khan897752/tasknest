package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class UsaveProjectServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String freelancer = req.getParameter("freelancer_name");
		 int projectId = Integer.parseInt(req.getParameter("project_id"));

	        UserDBlogic.unsaveProject(freelancer, projectId);

	        resp.sendRedirect("SavedProjects.jsp?success=Project removed");

	}

}
