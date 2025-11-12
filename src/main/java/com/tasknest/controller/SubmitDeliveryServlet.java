package com.tasknest.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import com.tasknest.model.DeliveryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/submitDelivery")
@MultipartConfig
@SuppressWarnings("serial")
public class SubmitDeliveryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔹 Get form parameters
        int projectId = Integer.parseInt(req.getParameter("projectId"));
        int freelancerId = Integer.parseInt(req.getParameter("freelancerId"));
        String deliveryNote = req.getParameter("deliveryNote");
        String linkUrl = req.getParameter("linkUrl");

        // 🔹 File part (from <input type="file">)
        Part filePart = req.getPart("deliveryFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // ✅ Get absolute path to the "uploads" folder inside webapp
        String uploadsDirPath = getServletContext().getRealPath("/uploads");

        // ✅ Create folder if missing
        File uploadsDir = new File(uploadsDirPath);
        if (!uploadsDir.exists()) {
            uploadsDir.mkdirs();
            System.out.println("Created uploads folder at: " + uploadsDirPath);
        }

        // ✅ Save file to that path
        String uploadPath = uploadsDirPath + File.separator + fileName;
        filePart.write(uploadPath);

        // ✅ Store relative path in database (for later access)
        String relativePath = "uploads/" + fileName;

        // ✅ Save delivery details in DB
        boolean success = DeliveryDAO.submitDelivery(projectId, freelancerId, deliveryNote, relativePath, linkUrl);

        // 🔹 Redirect or display message
        if (success) {
            resp.sendRedirect("freelancerDashboard.jsp?delivery=success");
        } else {
            resp.getWriter().println("Delivery submission failed. Please try again.");
        }
    }
}


