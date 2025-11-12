package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.AdminDBLogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/DeleteProjectServletBYAdmin")
public class DeleteProjectServletBYAdmin extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  String projectId = req.getParameter("projectId");
	        boolean success = false;

	        if (projectId != null && !projectId.trim().isEmpty()) {
	            success = AdminDBLogic.deleteProjectById(projectId);
	        }

	        if (success) {
	            resp.sendRedirect("AdminProjects.jsp?status=deleted");
	        } else {
	            resp.sendRedirect("AdminProjects.jsp?status=error");
	        }

	}

}
