package com.tasknest.controller;

import java.io.IOException;

import com.tasknest.model.UserDBlogic;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@SuppressWarnings("serial")
public class SendMessageServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String sender = req.getParameter("sender");
        String receiver = req.getParameter("receiver");
        String projectId = req.getParameter("project_id");
        String message = req.getParameter("message");
        
        System.out.println("Sender: " + sender);
        System.out.println("Receiver: " + receiver);
        System.out.println("Project ID: " + projectId);
        System.out.println("Message: " + message);

        UserDBlogic.sendMessage(sender, receiver, projectId, message);

        resp.sendRedirect("Messages.jsp?success=Message sent to " + receiver);

	}

}
