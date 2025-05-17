package com.app.grocery.controller;

import com.app.grocery.dao.OrderDAO;
import com.app.grocery.dao.ProductDAO;
import com.app.grocery.model.Order;
import com.app.grocery.util.OrderUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("edit".equals(action)) {
            Order order = OrderDAO.findById(id);
            req.setAttribute("order", order);
            assert order != null;
            req.setAttribute("selectedStatus", order.getStatus());

            List<String> productNames = ProductDAO.getProductNames();
            req.setAttribute("productNames", productNames);

            req.getRequestDispatcher("/order/order-form.jsp").forward(req, res);

        } else if ("add".equals(action)) {
            List<String> productNames = ProductDAO.getProductNames();
            req.setAttribute("productNames", productNames);

            req.getRequestDispatcher("/order/order-form.jsp").forward(req, res);

        } else if ("delete".equals(action)) {
            OrderDAO.delete(id);
            res.sendRedirect("order");

        } else {
            List<Order> orders = OrderDAO.getAll();
            req.setAttribute("orders", orders);
            req.setAttribute("queue", OrderUtil.getQueue());

            HttpSession session = req.getSession();
            @SuppressWarnings("unchecked")
            Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
            if (cart == null) cart = new HashMap<>();
            req.setAttribute("cart", cart);

            req.getRequestDispatcher("/order/order-list.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("checkout".equals(action)) {
            String userName = req.getParameter("userName");

            HttpSession session = req.getSession();
            @SuppressWarnings("unchecked")
            Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");

            if (cart != null && !cart.isEmpty()) {
                double totalAmount = 0;
                List<String> createdOrderIds = new ArrayList<>();

                for (Map.Entry<String, Integer> entry : cart.entrySet()) {
                    String productId = entry.getKey();
                    int qty = entry.getValue();

                    com.app.grocery.model.Product p = ProductDAO.findById(productId);
                    if (p != null) {
                        String orderId = UUID.randomUUID().toString();
                        double subtotal = p.getPrice() * qty;
                        totalAmount += subtotal;

                        Order order = new Order(orderId, userName, p.getProductName(), qty, "Pending", LocalDateTime.now());
                        OrderDAO.add(order);
                        OrderUtil.enqueue(order);

                        createdOrderIds.add(orderId);
                    }
                }

                cart.clear(); // clear cart after checkout
                session.setAttribute("cart", cart);

                session.setAttribute("checkoutOrderIds", createdOrderIds);
                session.setAttribute("checkoutAmount", totalAmount);
                session.setAttribute("checkoutUser", userName);

                res.sendRedirect("payment?action=add");
                return;
            }

            res.sendRedirect("order");
            return;
        }

        // Only relevant if NOT checkout
        String id = req.getParameter("id");
        String userName = req.getParameter("userName");
        String productName = req.getParameter("productName");
        String quantityStr = req.getParameter("quantity");
        String status = req.getParameter("status");

        int quantity = 0;
        if (quantityStr != null && !quantityStr.isEmpty()) {
            try {
                quantity = Integer.parseInt(quantityStr);
            } catch (NumberFormatException e) {
                quantity = 0; // Fallback to zero if parsing fails
            }
        }

        if (id == null || id.isEmpty()) {
            id = UUID.randomUUID().toString();
            Order newOrder = new Order(id, userName, productName, quantity, status, LocalDateTime.now());
            OrderDAO.add(newOrder);
        } else {
            Order updatedOrder = new Order(id, userName, productName, quantity, status, LocalDateTime.now());
            OrderDAO.update(updatedOrder);
        }

        res.sendRedirect("order");
    }
}
