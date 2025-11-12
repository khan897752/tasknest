package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PostProjectServlet")
@SuppressWarnings("serial")
public class PostProjectServlet extends HttpServlet{
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
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String budgetStr = req.getParameter("budget");
        String deadline = req.getParameter("deadline");
        String category = req.getParameter("category");
        
        try {
            double budget = Double.parseDouble(budgetStr);

            boolean success =UserDBlogic.insertProject(fullname, title, description, budget, deadline, category);

            if (success) {
                resp.sendRedirect("clientDashboard.jsp?success=project_posted");
            } else {
                resp.sendRedirect("PostProject.jsp?error=insert_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("PostProject.jsp?error=exception");
        }
 



	}

}
