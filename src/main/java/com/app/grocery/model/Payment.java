package com.app.grocery.model;

import java.time.LocalDateTime;

public class Payment {
    private String paymentId;
    private String orderId;
    private String userName;
    private double amount;
    private String status;
    private LocalDateTime paymentTime;

    public Payment(String paymentId, String orderId, String userName, double amount, String status, LocalDateTime paymentTime) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.userName = userName;
        this.amount = amount;
        this.status = status;
        this.paymentTime = paymentTime;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(LocalDateTime paymentTime) {
        this.paymentTime = paymentTime;
    }
}
