package com.app.grocery.dao;

import com.app.grocery.model.Order;
import com.app.grocery.util.FileUtil;
import com.app.grocery.util.OrderUtil;

import java.util.*;

public class OrderDAO {
    private static final String FILE_PATH = "data/orders.txt";

    public static void add(Order order) {
        List<Order> orders = getAll();
        orders.add(order);
        OrderUtil.enqueue(order); // Add to processing queue
        saveAll(orders);
    }

    public static List<Order> getAll() {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        List<Order> orders = new ArrayList<>();
        for (String line : lines) {
            orders.add(Order.fromFileString(line));
        }
        return orders;
    }

    public static void update(Order updatedOrder) {
        List<Order> orders = getAll();
        for (int i = 0; i < orders.size(); i++) {
            if (orders.get(i).getOrderId().equals(updatedOrder.getOrderId())) {
                orders.set(i, updatedOrder);
                break;
            }
        }
        saveAll(orders);
    }

    public static void delete(String orderId) {
        List<Order> orders = getAll();
        orders.removeIf(o -> o.getOrderId().equals(orderId));
        saveAll(orders);
    }

    public static Order findById(String id) {
        for (Order o : getAll()) {
            if (o.getOrderId().equals(id)) {
                return o;
            }
        }
        return null;
    }

    private static void saveAll(List<Order> orders) {
        List<String> lines = new ArrayList<>();
        for (Order o : orders) {
            lines.add(o.toFileString());
        }
        FileUtil.writeLines(FILE_PATH, lines);
    }
}
