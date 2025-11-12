package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.AdminDBLogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class ContactServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String role = req.getParameter("role");
        String message = req.getParameter("message");

        boolean success = AdminDBLogic.saveContactMessage(name, email, role, message);

        if (success) {
            resp.sendRedirect("Contactme.jsp?status=sent");
        } else {
            resp.sendRedirect("Contactme.jsp?status=error");
        }

 
	}

}
