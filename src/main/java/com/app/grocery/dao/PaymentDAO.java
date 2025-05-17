package com.app.grocery.dao;

import com.app.grocery.model.Payment;
import com.app.grocery.util.FileUtil;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private static final String FILE_PATH = "data/payments.txt";
    private static final String DELIMITER = "\\|";

    public static List<Payment> getAllPayments() {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        List<Payment> payments = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split(DELIMITER);
            if (parts.length == 6) {
                payments.add(new Payment(
                        parts[0], parts[1], parts[2],
                        Double.parseDouble(parts[3]),
                        parts[4],
                        LocalDateTime.parse(parts[5])
                ));
            }
        }
        return payments;
    }

    public static void addPayment(Payment payment) {
        List<String> lines = FileUtil.readLines(FILE_PATH);
        lines.add(String.format("%s|%s|%s|%.2f|%s|%s",
                payment.getPaymentId(), payment.getOrderId(),
                payment.getUserName(), payment.getAmount(),
                payment.getStatus(), payment.getPaymentTime()));
        FileUtil.writeLines(FILE_PATH, lines);
    }
}
