package com.app.grocery.controller;

import com.app.grocery.dao.CategoryDAO;
import com.app.grocery.model.Category;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("edit".equals(action)) {
            Category category = CategoryDAO.findById(id);
            req.setAttribute("category", category);
            req.getRequestDispatcher("/category/category-form.jsp").forward(req, res);
        } else if ("add".equals(action)) {
            req.getRequestDispatcher("/category/category-form.jsp").forward(req, res);
        } else if ("delete".equals(action)) {
            CategoryDAO.delete(id);
            res.sendRedirect("category");
        } else {
            req.setAttribute("categories", CategoryDAO.getAll());
            req.getRequestDispatcher("/category/category-list.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String id = UUID.randomUUID().toString();
            Category newCategory = new Category(id, name, description);
            CategoryDAO.add(newCategory);
            res.sendRedirect("category");
        } else if ("edit".equals(action)) {
            String id = req.getParameter("id");
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            Category updatedCategory = new Category(id, name, description);
            CategoryDAO.update(updatedCategory);
            res.sendRedirect("category");
        }
    }
}
