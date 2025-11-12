package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class SaveProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String skills = req.getParameter("skills");
        String bio = req.getParameter("bio");

        // Removed profile picture logic
        UserDBlogic.saveOrUpdateFreelancerProfile(fullname, email, skills, bio);

        resp.sendRedirect("MyProfile.jsp?success=Profile updated");
    }
}
