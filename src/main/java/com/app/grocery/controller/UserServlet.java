package com.app.grocery.controller;

import com.app.grocery.dao.UserDAO;
import com.app.grocery.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("edit".equals(action)) {
            User user = UserDAO.findById(id);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/user/user-form.jsp").forward(req, res);
        } else if ("add".equals(action)) {
            req.getRequestDispatcher("/user/user-form.jsp").forward(req, res);
        } else if ("delete".equals(action)) {
            UserDAO.delete(id);
            res.sendRedirect("user");
        } else if ("login".equals(action)) {
            req.getRequestDispatcher("/user/login.jsp").forward(req, res);
        } else if ("signup".equals(action)) {
            req.getRequestDispatcher("/user/signup.jsp").forward(req, res);
        } else {
            req.setAttribute("users", UserDAO.getAll());
            req.getRequestDispatcher("/user/user-list.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("login".equals(action)) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            //Hardcoded Admin Check
            if ("admin@grocery.com".equals(email) && "admin123".equals(password)) {
                HttpSession session = req.getSession();
                session.setAttribute("isAdmin", true);
                res.sendRedirect("admin-dashboard");
                return;
            }

            User user = UserDAO.login(email, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("loggedInUser", user.getName()); // ✅ Set username in session
                res.sendRedirect("dashboard");
            } else {
                req.setAttribute("error", "Invalid login credentials.");
                req.getRequestDispatcher("/user/login.jsp").forward(req, res);
            }

        } else if ("signup".equals(action)) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            String password = req.getParameter("password");

            if (UserDAO.findByEmail(email) != null) {
                req.setAttribute("error", "Email already exists.");
                req.getRequestDispatcher("/user/signup.jsp").forward(req, res);
            } else {
                String id = UUID.randomUUID().toString();
                User newUser = new User(id, name, email, phone, address, password);
                UserDAO.add(newUser);
                res.sendRedirect("user?action=login");
            }
        } else {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String password = req.getParameter("password");

        if (id == null || id.isEmpty()) {
            id = UUID.randomUUID().toString();
            User newUser = new User(id, name, email, phone, address, password);
            UserDAO.add(newUser);
        } else {
            User updatedUser = new User(id, name, email, phone, address, password);
            UserDAO.update(updatedUser);

            // Update session with latest user info
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.setAttribute("user", updatedUser);
                session.setAttribute("loggedInUser", updatedUser.getName());
            }
        }

        res.sendRedirect("dashboard");
    }

}
}
