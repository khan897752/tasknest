package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteProjectServlet")
@SuppressWarnings("serial")
public class DeleteProjectServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession(false);
        String fullname = (String) session.getAttribute("fullname");
        String role = (String) session.getAttribute("role");

        if (fullname == null || role == null || !"client".equals(role)) {
            resp.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        String projectId = req.getParameter("projectId");

        boolean success = UserDBlogic.deleteProjectById(projectId, fullname);

        if (success) {
            resp.sendRedirect("ManageProjects.jsp?success=deleted");
        } else {
            resp.sendRedirect("ManageProjects.jsp?error=delete_failed");
        }

	}

}
