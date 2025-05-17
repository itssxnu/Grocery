package com.app.grocery.controller;

import com.app.grocery.dao.ProductDAO;
import com.app.grocery.dao.CategoryDAO;
import com.app.grocery.model.Product;

import com.app.grocery.util.ProductUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("edit".equals(action)) {
            Product product = ProductDAO.findById(id);
            req.setAttribute("product", product);
            req.setAttribute("categories", CategoryDAO.getAllCategories());
            req.getRequestDispatcher("/product/product-form.jsp").forward(req, res);
            return;

        } else if ("add".equals(action)) {
            req.setAttribute("categories", CategoryDAO.getAllCategories());
            req.getRequestDispatcher("/product/product-form.jsp").forward(req, res);
            return;

        } else if ("delete".equals(action)) {
            ProductDAO.delete(id);
            res.sendRedirect("product");
            return;
        }

        // Default: list products
        String sortBy = req.getParameter("sortBy");
        List<Product> products = ProductDAO.getAll();

        if ("category".equals(sortBy)) {
            products = ProductUtil.sortByCategory(products);
        } else if ("price".equals(sortBy)) {
            products = ProductUtil.sortByPrice(products);
        }

        req.setAttribute("products", products);
        req.setAttribute("categories", CategoryDAO.getAllCategories());
        req.getRequestDispatcher("/product/product-list.jsp").forward(req, res);
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("productName");
        String category = req.getParameter("category");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        if (id == null || id.isEmpty()) {
            id = UUID.randomUUID().toString();
            ProductDAO.add(new Product(id, name, category, price, quantity));

        } else {
            ProductDAO.update(new Product(id, name, category, price, quantity));
        }

        res.sendRedirect("product");
    }
}
