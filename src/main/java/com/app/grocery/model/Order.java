package com.app.grocery.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Order {
    private String orderId;
    private String userName;
    private String productName;
    private int quantity;
    private String status;
    private LocalDateTime timestamp;

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Order(String orderId, String userName, String productName, int quantity, String status, LocalDateTime timestamp) {
        this.orderId = orderId;
        this.userName = userName;
        this.productName = productName;
        this.quantity = quantity;
        this.status = status;
        this.timestamp = timestamp;
    }

    public String getOrderId() {
        return orderId;
    }

    public String getUserName() {
        return userName;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String toFileString() {
        return String.join("|",
                orderId,
                userName,
                productName,
                String.valueOf(quantity),
                status,
                timestamp.format(formatter)
        );
    }

    public static Order fromFileString(String line) {
        String[] parts = line.split("\\|");
        return new Order(
                parts[0],
                parts[1],
                parts[2],
                Integer.parseInt(parts[3]),
                parts[4],
                LocalDateTime.parse(parts[5], formatter)
        );
    }
}
