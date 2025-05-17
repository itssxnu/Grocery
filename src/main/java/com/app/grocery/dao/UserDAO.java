package com.app.grocery.dao;

import com.app.grocery.model.User;
import com.app.grocery.util.FileUtil;

import java.io.File;
import java.util.*;

public class UserDAO {
    private static final String FILE_PATH = "data/users.txt";
    private static final String DELIMITER = "\\|";

    public static List<User> getAll() {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        List<User> users = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split(DELIMITER);
            if (parts.length == 6) {
                users.add(new User(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
            }
        }
        return users;
    }

    public static void add(User user) {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        lines.add(String.join("|", user.getId(), user.getName(), user.getEmail(), user.getPhone(), user.getAddress(),user.getPassword()));
        System.out.println("Saving to: " + new File(FILE_PATH).getAbsolutePath());
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static void update(User updatedUser) {
        List<User> users = getAll();
        List<String> lines = new ArrayList<>();
        for (User u : users) {
            if (u.getId().equals(updatedUser.getId())) {
                lines.add(String.join("|", updatedUser.getId(), updatedUser.getName(), updatedUser.getEmail(), updatedUser.getPhone(), updatedUser.getAddress(), updatedUser.getPassword()));
            } else {
                lines.add(String.join("|", u.getId(), u.getName(), u.getEmail(), u.getPhone(), u.getAddress(), u.getPassword()));
            }
        }
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static void delete(String id) {
        List<User> users = getAll();
        List<String> lines = new ArrayList<>();
        for (User u : users) {
            if (!u.getId().equals(id)) {
                lines.add(String.join("|", u.getId(), u.getName(), u.getEmail(), u.getPhone(), u.getAddress(), u.getPassword()));
            }
        }
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static User findById(String id) {
        for (User u : getAll()) {
            if (u.getId().equals(id)) return u;
        }
        return null;
    }

    // Login method: Checks if the user exists with the correct email and password
    public static User login(String email, String password) {
        for (User user : getAll()) {
            if (user.getEmail().trim().equals(email) && user.getPassword().trim().equals(password)) {
                return user;
            }
        }
        return null; // Invalid login
    }

    // Find user by email for signup validation
    public static User findByEmail(String email) {
        for (User user : getAll()) {
            if (user.getEmail().equals(email)) {
                return user;
            }
        }
        return null; // Email not found
    }
}
