package com.app.grocery.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Boolean isAdmin = (session != null) && Boolean.TRUE.equals(session.getAttribute("isAdmin"));

        if (!isAdmin) {
            res.sendRedirect("user?action=login");
            return;
        }

        req.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(req, res);
    }
}
