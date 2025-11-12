package com.tasknest.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.tasknest.model.AccountUser;
import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String email = req.getParameter("email");
	        String password = req.getParameter("password");
	        String selectedRole = req.getParameter("role"); 

	        try {
	            AccountUser ac = UserDBlogic.login(email, password);
	            if (ac != null) {
	                HttpSession s = req.getSession();
	                s.setAttribute("fullname", ac.getFullname());
	                s.setAttribute("email", ac.getEmail());
	                s.setAttribute("username", ac.getUsername());
	                s.setAttribute("role", ac.getRole());
	                s.setAttribute("freelancerId", ac.getId());

	                
	                if (selectedRole != null && selectedRole.equalsIgnoreCase(ac.getRole())) {
	                    if ("client".equalsIgnoreCase(ac.getRole())) {
	                        resp.sendRedirect("clientDashboard.jsp");
	                    } else if ("freelancer".equalsIgnoreCase(ac.getRole())) {
	                        resp.sendRedirect("freelancerDashboard.jsp");
	                    } else {
	                        resp.sendRedirect("login.jsp?error=unknown_role");
	                    }
	                } else {
	                    resp.sendRedirect("login.jsp?error=role_mismatch");
	                }
	            } else {
	                resp.sendRedirect("login.jsp?error=invalid_credentials");
	            }
	        } catch (ClassNotFoundException | SQLException e) {
	            e.printStackTrace();
	            resp.sendRedirect("login.jsp?error=server_error");
	        }


		
	}

}
