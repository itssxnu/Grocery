<%@ page import="com.app.grocery.model.Payment" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment History</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        darkest: '#1A1A19',
                        dark: '#31511E',
                        accent: '#859F3D',
                        light: '#F6FCDF',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-light min-h-screen p-6">
<div class="max-w-6xl mx-auto">
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-2xl font-bold text-dark">Payment History</h2>
        <a href="admin-dashboard" class="bg-dark hover:bg-darkest text-white font-bold py-2 px-4 rounded">Back to Dashboard</a>
    </div>

    <div class="overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg overflow-hidden">
            <thead class="bg-dark text-light">
            <tr>
                <th class="py-3 px-4 text-left">Payment ID</th>
                <th class="py-3 px-4 text-left">Order ID</th>
                <th class="py-3 px-4 text-left">User Name</th>
                <th class="py-3 px-4 text-left">Amount</th>
                <th class="py-3 px-4 text-left">Status</th>
                <th class="py-3 px-4 text-left">Payment Time</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
            <%
                List<Payment> payments = (List<Payment>) request.getAttribute("payments");
                if (payments != null && !payments.isEmpty()) {
                    for (Payment payment : payments) {
            %>
            <tr class="hover:bg-gray-50">
                <td class="py-3 px-4"><%= payment.getPaymentId() %></td>
                <td class="py-3 px-4"><%= payment.getOrderId() %></td>
                <td class="py-3 px-4"><%= payment.getUserName() %></td>
                <td class="py-3 px-4"><%= payment.getAmount() %> LKR</td>
                <td class="py-3 px-4">
                        <span class="px-2 py-1 rounded-full text-xs
                            <%= "completed".equals(payment.getStatus()) ? "bg-green-100 text-green-800" :
                               "pending".equals(payment.getStatus()) ? "bg-yellow-100 text-yellow-800" :
                               "bg-red-100 text-red-800" %>">
                            <%= payment.getStatus() %>
                        </span>
                </td>
                <td class="py-3 px-4"><%= payment.getPaymentTime() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6" class="py-4 px-4 text-center text-gray-500">No payment records found.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="mt-6">
        <a href="order" class="text-accent hover:text-dark">Go back to Order List</a>
    </div>
</div>
</body>
</html>