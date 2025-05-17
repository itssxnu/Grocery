package com.app.grocery.util;

import com.app.grocery.model.Product;

import java.util.*;

public class ProductUtil {

    // Sort by category (alphabetically)
    public static List<Product> sortByCategory(List<Product> products) {
        if (products == null || products.size() <= 1) return products;
        int mid = products.size() / 2;
        List<Product> left = sortByCategory(new ArrayList<>(products.subList(0, mid)));
        List<Product> right = sortByCategory(new ArrayList<>(products.subList(mid, products.size())));
        return mergeByCategory(left, right);
    }

    private static List<Product> mergeByCategory(List<Product> left, List<Product> right) {
        List<Product> merged = new ArrayList<>();
        int i = 0, j = 0;
        while (i < left.size() && j < right.size()) {
            if (left.get(i).getCategory().compareToIgnoreCase(right.get(j).getCategory()) <= 0) {
                merged.add(left.get(i++));
            } else {
                merged.add(right.get(j++));
            }
        }
        while (i < left.size()) merged.add(left.get(i++));
        while (j < right.size()) merged.add(right.get(j++));
        return merged;
    }

    // Sort by price (ascending)
    public static List<Product> sortByPrice(List<Product> products) {
        if (products == null || products.size() <= 1) return products;
        int mid = products.size() / 2;
        List<Product> left = sortByPrice(new ArrayList<>(products.subList(0, mid)));
        List<Product> right = sortByPrice(new ArrayList<>(products.subList(mid, products.size())));
        return mergeByPrice(left, right);
    }

    private static List<Product> mergeByPrice(List<Product> left, List<Product> right) {
        List<Product> merged = new ArrayList<>();
        int i = 0, j = 0;
        while (i < left.size() && j < right.size()) {
            if (left.get(i).getPrice() <= right.get(j).getPrice()) {
                merged.add(left.get(i++));
            } else {
                merged.add(right.get(j++));
            }
        }
        while (i < left.size()) merged.add(left.get(i++));
        while (j < right.size()) merged.add(right.get(j++));
        return merged;
    }
}
