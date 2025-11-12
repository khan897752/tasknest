package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateProjectServlet")
@SuppressWarnings("serial")
public class UpdateProjectServlet extends HttpServlet{
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

        String id = req.getParameter("id");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String budgetStr = req.getParameter("budget");
        String deadline = req.getParameter("deadline");
        String category = req.getParameter("category");
        try {
            double budget = Double.parseDouble(budgetStr);

            boolean success = UserDBlogic.updateProject(id, fullname, title, description, budget, deadline, category);

            if (success) {
                resp.sendRedirect("ManageProjects.jsp?success=updated");
            } else {
                resp.sendRedirect("EditProject.jsp?id=" + id + "&error=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("EditProject.jsp?id=" + id + "&error=exception");
        }


	}

}
