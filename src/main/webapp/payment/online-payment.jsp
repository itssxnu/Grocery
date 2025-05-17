<%--
  Created by IntelliJ IDEA.
  User: sanus
  Date: 5/4/2025
  Time: 12:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FreshMart Pay | Secure Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
    <style>
        @keyframes pulse-glow {
            0% { box-shadow: 0 0 0 0 rgba(74, 222, 128, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(74, 222, 128, 0); }
            100% { box-shadow: 0 0 0 0 rgba(74, 222, 128, 0); }
        }
        .card-input {
            background: linear-gradient(135deg, #1a1a19 0%, #2d3748 100%);
            color: #f6fcdf;
            border: 1px solid #4ade80;
        }
        .card-input:focus {
            outline: none;
            border-color: #859f3d;
            animation: pulse-glow 1.5s infinite;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-900 to-gray-800 min-h-screen flex items-center justify-center p-4">

<div class="max-w-md w-full bg-gradient-to-br from-gray-800 to-gray-700 p-8 rounded-2xl shadow-2xl border border-gray-600">
    <!-- Futuristic header with animated border -->
    <div class="relative mb-8 pb-4 border-b border-gray-600">
        <div class="absolute -bottom-px left-0 right-0 h-px bg-gradient-to-r from-transparent via-green-400 to-transparent"></div>
        <h2 class="text-3xl font-bold text-center text-transparent bg-clip-text bg-gradient-to-r from-green-400 to-blue-400">
            FRESHMART PAY
        </h2>
    </div>

    <form action="payment" method="post" class="space-y-6" id="paymentForm">
        <!-- Hidden Order ID -->
        <input type="hidden" name="orderId" value="<%= request.getAttribute("orderId") %>" />

        <!-- Card Container with futuristic design -->
        <div class="relative">
            <div class="absolute -inset-0.5 bg-gradient-to-r from-green-400 to-blue-500 rounded-lg blur opacity-75"></div>
            <div class="relative bg-gray-800 rounded-lg p-5">
                <!-- Card Top -->
                <div class="flex justify-between items-center mb-6">
                    <div class="text-green-400 font-mono text-sm">VIRTUAL CARD</div>
                    <div class="flex space-x-2">
                        <div class="w-8 h-8 bg-yellow-400 rounded-full"></div>
                        <div class="w-8 h-8 bg-red-400 rounded-full opacity-75"></div>
                    </div>
                </div>

                <!-- Card Number -->
                <div class="mb-6">
                    <input type="text" name="cardNumber" id="cardNumber" required maxlength="19"
                           class="w-full card-input p-3 rounded-md font-mono tracking-widest"
                           placeholder="•••• •••• •••• ••••"
                           oninput="formatCardNumber(this)"
                           value="">
                </div>

                <!-- Card Bottom -->
                <div class="flex justify-between">
                    <div>
                        <label class="block text-gray-400 text-xs mb-1">CARDHOLDER</label>
                        <input type="text" name="userName" id="userName" required
                               class="card-input p-2 rounded-md w-full"
                               value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>"
                               placeholder="YOUR NAME">
                    </div>
                    <div>
                        <label class="block text-gray-400 text-xs mb-1">EXPIRES</label>
                        <input type="text" name="expiryDate" id="expiryDate" required
                               class="card-input p-2 rounded-md w-full"
                               placeholder="MM/YY">
                    </div>
                    <div>
                        <label class="block text-gray-400 text-xs mb-1">CVV</label>
                        <input type="text" name="cvv" id="cvv" required maxlength="3"
                               class="card-input p-2 rounded-md w-full"
                               placeholder="•••">
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Amount Display -->
        <div class="bg-gray-800 p-4 rounded-lg border border-gray-700">
            <div class="flex justify-between items-center">
                <span class="text-gray-400">Total Amount</span>
                <span class="text-2xl font-bold text-green-400">
                    <%= request.getAttribute("orderAmount") %> LKR
                </span>
                <input type="hidden" name="amount" value="<%= request.getAttribute("orderAmount") %>">

            </div>
        </div>

        <!-- Status Selector -->
        <div class="flex items-center justify-between bg-gray-800 p-3 rounded-lg">
            <span class="text-gray-400">Payment Status</span>
            <div class="relative">
                <select name="status" id="status"
                        class="appearance-none bg-gray-900 text-green-400 px-4 py-2 pr-8 rounded border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-400">
                    <option value="Completed">Completed</option>
                    <option value="Pending">Pending</option>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-400">
                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
            </div>
        </div>

        <!-- Submit Button -->
        <button type="submit"
                class="w-full bg-gradient-to-r from-green-400 to-blue-500 text-white font-bold py-4 px-4 rounded-lg hover:from-green-500 hover:to-blue-600 transition-all duration-300 shadow-lg hover:shadow-xl active:scale-95 transform">
            CONFIRM PAYMENT
        </button>
    </form>
</div>

<script>
    function formatCardNumber(input) {
        let value = input.value.replace(/\D/g, '');
        let formatted = '';
        for (let i = 0; i < value.length; i += 4) {
            if (i > 0) formatted += ' ';
            formatted += value.substring(i, i + 4);
        }
        input.value = formatted.trim();
    }

    document.getElementById("paymentForm").addEventListener("submit", function (event) {
        const cardNumber = document.getElementById("cardNumber").value;
        const expiryDate = document.getElementById("expiryDate").value;
        const cvv = document.getElementById("cvv").value;

        if (!cardNumber || !expiryDate || !cvv) {
            alert("Please complete all payment details");
            event.preventDefault();
        }

        if (!/^(\d{4} \d{4} \d{4} \d{4})$/.test(cardNumber)) {
            alert("Please enter a valid 16-digit card number");
            event.preventDefault();
        }

        if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
            alert("Please enter expiration date in MM/YY format");
            event.preventDefault();
        }

        if (!/^\d{3}$/.test(cvv)) {
            alert("Please enter a valid 3-digit CVV");
            event.preventDefault();
        }
    });

    // Add automatic formatting for expiry date
    document.getElementById("expiryDate").addEventListener("input", function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }
        e.target.value = value;
    });
</script>

</body>
</html>