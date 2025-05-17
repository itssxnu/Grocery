package com.app.grocery.controller;

import com.app.grocery.dao.ProductDAO;
import com.app.grocery.model.Product;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.util.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Map<String, Integer> cart = (Map<String, Integer>) req.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        List<Product> cartItems = new ArrayList<>();
        double total = 0;

        for (Map.Entry<String, Integer> entry : cart.entrySet()) {
            Product p = ProductDAO.findById(entry.getKey());
            if (p != null) {
                int qty = entry.getValue();
                total += p.getPrice() * qty;
                p.setQuantity(qty); // temporarily reuse quantity to show cart quantity
                cartItems.add(p);
            }
        }

        int cartCount = 0;
        for (Product item : cartItems) {
            cartCount += item.getQuantity(); // Quantity here is used for cart quantity
        }
        req.setAttribute("cartCount", cartCount); // so it can be shown in JSP


        req.setAttribute("cartItems", cartItems);
        req.setAttribute("total", total);
        req.getRequestDispatcher("dashboard").forward(req, res);
    }

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String productId = req.getParameter("productId");
        if (productId == null || productId.trim().isEmpty()) {
            res.sendRedirect("cart");
            return;
        }

        int quantity = 0;
        try {
            quantity = Integer.parseInt(req.getParameter("quantity"));
        } catch (NumberFormatException e) {
            quantity = 1; // default or redirect with error
        }


        HttpSession session = req.getSession();
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        switch (action) {
            case "add":
                cart.put(productId, cart.getOrDefault(productId, 0) + quantity);
                break;
            case "remove":
                cart.remove(productId);
                break;
            case "update":
                if (quantity > 0) cart.put(productId, quantity);
                else cart.remove(productId);
                break;
            case "clear":
                cart.clear();
                break;
            case "increase":
                cart.put(productId, cart.getOrDefault(productId, 0) + 1);
                break;
            case "decrease":
                int currentQty = cart.getOrDefault(productId, 0);
                if (currentQty > 1) cart.put(productId, currentQty - 1);
                else cart.remove(productId);
                break;

        }

        session.setAttribute("cart", cart);
        res.sendRedirect("cart");
    }
}
