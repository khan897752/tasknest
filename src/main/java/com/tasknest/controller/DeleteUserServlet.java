package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.AdminDBLogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class DeleteUserServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  String email = req.getParameter("email");
	        boolean success = false;

	        if (email != null && !email.trim().isEmpty()) {
	            success = AdminDBLogic.deleteUserByEmail(email);
	        }

	        if (success) {
	            resp.sendRedirect("AdminUsers.jsp?status=deleted");
	        } else {
	            resp.sendRedirect("AdminUsers.jsp?status=error");
	        }

	}

}
