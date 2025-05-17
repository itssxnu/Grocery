package com.app.grocery.dao;

import com.app.grocery.model.Category;
import com.app.grocery.util.FileUtil;

import java.util.*;

public class CategoryDAO {
    private static final String FILE_PATH = "data/categories.txt";
    private static final String DELIMITER = "\\|";

    public static List<Category> getAll() {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        List<Category> categories = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split(DELIMITER);
            if (parts.length == 3) {
                categories.add(new Category(parts[0], parts[1], parts[2]));
            }
        }
        return categories;
    }

    public static void add(Category category) {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        lines.add(String.join("|", category.getId(), category.getName(), category.getDescription()));
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static void update(Category updatedCategory) {
        List<Category> categories = getAll();
        List<String> lines = new ArrayList<>();
        for (Category c : categories) {
            if (c.getId().equals(updatedCategory.getId())) {
                lines.add(String.join("|", updatedCategory.getId(), updatedCategory.getName(), updatedCategory.getDescription()));
            } else {
                lines.add(String.join("|", c.getId(), c.getName(), c.getDescription()));
            }
        }
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static void delete(String id) {
        List<Category> categories = getAll();
        List<String> lines = new ArrayList<>();
        for (Category c : categories) {
            if (!c.getId().equals(id)) {
                lines.add(String.join("|", c.getId(), c.getName(), c.getDescription()));
            }
        }
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static Category findById(String id) {
        for (Category c : getAll()) {
            if (c.getId().equals(id)) return c;
        }
        return null;
    }

    public static List<String> getAllCategories() {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        List<String> categories = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 2) {
                categories.add(parts[1]);
            }
        }
        return categories;
    }

}
