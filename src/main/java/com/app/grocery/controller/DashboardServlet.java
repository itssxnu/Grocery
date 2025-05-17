package com.app.grocery.controller;

import com.app.grocery.dao.CategoryDAO;
import com.app.grocery.dao.ProductDAO;
import com.app.grocery.model.Product;
import com.app.grocery.util.ProductUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String selectedCategory = req.getParameter("category");
        String sort = req.getParameter("sort");

        List<Product> products;

        if (selectedCategory != null && !selectedCategory.equalsIgnoreCase("All")) {
            products = ProductDAO.getByCategory(selectedCategory); // assumes this method exists
        } else {
            products = ProductDAO.getAll();
        }

        // Apply sorting based on parameter
        if ("price".equals(sort)) {
            products = ProductUtil.sortByPrice(products);
        } else if ("category".equals(sort)) {
            products = ProductUtil.sortByCategory(products);
        }

        req.setAttribute("products", products);
        req.setAttribute("categoryNames", CategoryDAO.getAllCategories());
        req.setAttribute("selectedCategory", selectedCategory);
        req.setAttribute("selectedSort", sort); // Pass to JSP to retain dropdown selection
        req.getRequestDispatcher("/dashboard/dashboard.jsp").forward(req, res);
    }
}
