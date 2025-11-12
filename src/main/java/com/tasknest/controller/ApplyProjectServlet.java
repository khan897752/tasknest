package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ApplyProjectServlet")
@SuppressWarnings("serial")
public class ApplyProjectServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 HttpSession session = req.getSession(false);
	        String freelancerName = (String) session.getAttribute("fullname");
	        String role = (String) session.getAttribute("role");
            
	        if (freelancerName == null || role == null || !"freelancer".equals(role)) {
	            resp.sendRedirect("login.jsp?error=unauthorized");
	            return;
	        }

	        String projectId = req.getParameter("project_id");
	        String clientName = req.getParameter("client_name");
	        String proposal = req.getParameter("proposal");
	        String budgetStr = req.getParameter("expected_budget");
	        String daysStr = req.getParameter("estimated_days");
            
	        try {
	            double expectedBudget = Double.parseDouble(budgetStr);
	            int estimatedDays = Integer.parseInt(daysStr);

	            boolean success = UserDBlogic.submitApplication(projectId, clientName, freelancerName, proposal, expectedBudget, estimatedDays);

	            if (success) {
	                resp.sendRedirect("BrowseProjects.jsp?success=applied");
	            } else {
	                resp.sendRedirect("ApplyProject.jsp?id=" + projectId + "&error=failed");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            resp.sendRedirect("ApplyProject.jsp?id=" + projectId + "&error=exception");
	        }

	}

}
