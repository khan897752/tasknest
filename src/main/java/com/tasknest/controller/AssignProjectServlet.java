package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AssignProjectServlet")
@SuppressWarnings("serial")
public class AssignProjectServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    String projectId = req.getParameter("project_id");
	    String freelancerName = req.getParameter("freelancer_name");

	    boolean assigned = UserDBlogic.assignProject(projectId, freelancerName);
	    
	    System.out.println("Assigning project ID: " + req.getParameter("project_id"));
	    System.out.println("To freelancer: " + req.getParameter("freelancer_name"));

	    if (assigned) {
	    	resp.sendRedirect("ViewApplications.jsp?id=" + projectId + "&assigned=true");
	    } else {
	      resp.sendRedirect("ViewApplications.jsp?error=assign_failed");
	    }

	}

}
