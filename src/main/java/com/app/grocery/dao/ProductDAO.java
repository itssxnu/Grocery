package com.app.grocery.dao;

import com.app.grocery.model.Product;
import com.app.grocery.util.FileUtil;

import java.util.*;
import java.util.stream.Collectors;

public class ProductDAO {
    private static final String FILE_PATH = "data/products.txt";
    private static final String DELIMITER = "\\|";

    public static List<Product> getAll() {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        List<Product> products = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split(DELIMITER);
            if (parts.length == 5) {
                products.add(new Product(
                        parts[0], parts[1], parts[2],
                        Double.parseDouble(parts[3]),
                        Integer.parseInt(parts[4])
                ));
            }
        }
        return products;
    }

    public static List<String> getProductNames() {
        List<String> names = new ArrayList<>();
        List<String> lines = FileUtil.readLines(FILE_PATH);
        for (String line : lines) {
            String[] parts = line.split(DELIMITER);
            if (parts.length >= 2) {
                names.add(parts[1]); // 2nd element is productName
            }
        }
        return names;
    }


    public static void add(Product product) {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        lines.add(String.join("|", product.getProductID(), product.getProductName(),
                product.getCategory(), String.valueOf(product.getPrice()),
                String.valueOf(product.getQuantity())));
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static void update(Product updated) {
        List<Product> products = getAll();
        List<String> lines = new ArrayList<>();
        for (Product p : products) {
            if (p.getProductID().equals(updated.getProductID())) {
                lines.add(String.join("|", updated.getProductID(), updated.getProductName(),
                        updated.getCategory(), String.valueOf(updated.getPrice()),
                        String.valueOf(updated.getQuantity())));
            } else {
                lines.add(String.join("|", p.getProductID(), p.getProductName(),
                        p.getCategory(), String.valueOf(p.getPrice()),
                        String.valueOf(p.getQuantity())));
            }
        }
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static void delete(String id) {
        List<Product> products = getAll();
        List<String> lines = new ArrayList<>();
        for (Product p : products) {
            if (!p.getProductID().equals(id)) {
                lines.add(String.join("|", p.getProductID(), p.getProductName(),
                        p.getCategory(), String.valueOf(p.getPrice()),
                        String.valueOf(p.getQuantity())));
            }
        }
        FileUtil.writeLines(FILE_PATH, lines);
    }

    public static Product findById(String id) {
        for (Product p : getAll()) {
            if (p.getProductID().equals(id)) return p;
        }
        return null;
    }

    public static List<Product> getByCategory(String category) {
        return getAll().stream()
                .filter(p -> p.getCategory().equalsIgnoreCase(category))
                .collect(Collectors.toList());
    }


}
