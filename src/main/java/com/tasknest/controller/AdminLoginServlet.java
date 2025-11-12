package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.AdminDBLogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class AdminLoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();

        String fullname = AdminDBLogic.validateAdmin(email, password); 

        if (fullname != null) {
            HttpSession session = req.getSession();
            session.setAttribute("fullname", fullname);
            session.setAttribute("email", email);
            session.setAttribute("role", "admin");

            resp.sendRedirect("AdminDashboard.jsp");
        } else {
            resp.sendRedirect("adminLogin.jsp?error=invalid");
        }

	}

}
