package com.tasknest.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/FreelancerSignupServlet")
public class SignupFreelancerServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String fullname = req.getParameter("fullname");
	        String email = req.getParameter("email");
	        String username = req.getParameter("username");
	        String password = req.getParameter("password");
	        String confirmPassword = req.getParameter("confirmPassword");

	        if (!password.equals(confirmPassword)) {
	            resp.sendRedirect("signupFreelancer.jsp?error=password_mismatch");
	            return;
	        }

	        try {
	            if (UserDBlogic.userExists(email, username)) {
	                resp.sendRedirect("signupFreelancer.jsp?error=exists");
	                return;
	            }
	            String role = "freelancer";
	            boolean result = UserDBlogic.createClientAccount(fullname, email, username, password, role);

	            if (result) {
	                resp.sendRedirect("login.jsp?fullname=" + fullname);
	            } else {
	                resp.sendRedirect("signupFreelancer.jsp?error=insert_failed");
	            }

	        } catch (ClassNotFoundException | SQLException e) {
	            e.printStackTrace();
	            resp.sendRedirect("signupFreelancer.jsp?error=server_error");
	        }
	}

}
