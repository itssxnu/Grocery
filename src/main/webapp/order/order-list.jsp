<%@ page import="com.app.grocery.model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Order List</title>
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
    <h2 class="text-2xl font-bold text-dark">Order List</h2>
    <a href="admin-dashboard" class="bg-dark hover:bg-darkest text-white font-bold py-2 px-4 rounded">Back to Dashboard</a>
  </div>
  <a href="order?action=add" class="inline-block bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded mb-6">Add New Order</a>

  <div class="bg-white rounded-lg shadow-md overflow-hidden mb-8">
    <table class="min-w-full">
      <thead class="bg-dark text-light">
      <tr>
        <th class="py-3 px-4 text-left">Order ID</th>
        <th class="py-3 px-4 text-left">User Name</th>
        <th class="py-3 px-4 text-left">Product Name</th>
        <th class="py-3 px-4 text-left">Quantity</th>
        <th class="py-3 px-4 text-left">Status</th>
        <th class="py-3 px-4 text-left">Actions</th>
      </tr>
      </thead>
      <tbody class="divide-y divide-gray-200">
      <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
          for (Order order : orders) {
      %>
      <tr class="hover:bg-gray-50">
        <td class="py-3 px-4"><%= order.getOrderId() %></td>
        <td class="py-3 px-4"><%= order.getUserName() %></td>
        <td class="py-3 px-4"><%= order.getProductName() %></td>
        <td class="py-3 px-4"><%= order.getQuantity() %></td>
        <td class="py-3 px-4">
                        <span class="px-2 py-1 rounded-full text-xs
                            <%= "completed".equals(order.getStatus()) ? "bg-green-100 text-green-800" :
                               "pending".equals(order.getStatus()) ? "bg-yellow-100 text-yellow-800" :
                               "bg-red-100 text-red-800" %>">
                            <%= order.getStatus() %>
                        </span>
        </td>
        <td class="py-3 px-4">
          <a href="order?action=edit&id=<%= order.getOrderId() %>" class="text-accent hover:text-dark mr-2">Edit</a>
          <a href="order?action=delete&id=<%= order.getOrderId() %>" class="text-red-500 hover:text-red-700">Delete</a>
        </td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="6" class="py-4 px-4 text-center text-gray-500">No orders found.</td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>

  <div class="grid md:grid-cols-2 gap-6">
    <div class="bg-white p-4 rounded-lg shadow-md">
      <h3 class="text-lg font-bold text-dark mb-3">Processing Queue</h3>
      <%
        java.util.Queue<Order> queue = (java.util.Queue<Order>) request.getAttribute("queue");
        if (queue != null && !queue.isEmpty()) {
      %>
      <ul class="space-y-2">
        <%
          for (Order qOrder : queue) {
        %>
        <li class="border-b pb-2 last:border-0">
          <strong class="text-dark"><%= qOrder.getUserName() %></strong> -
          <%= qOrder.getProductName() %> (Qty: <%= qOrder.getQuantity() %>,
          <span class="<%= "completed".equals(qOrder.getStatus()) ? "text-green-600" :
                                 "pending".equals(qOrder.getStatus()) ? "text-yellow-600" :
                                 "text-red-600" %>">
                        <%= qOrder.getStatus() %>
                    </span>)
        </li>
        <%
          }
        %>
      </ul>
      <%
      } else {
      %>
      <p class="text-gray-500">No orders in the queue.</p>
      <%
        }
      %>
    </div>

    <div class="bg-white p-4 rounded-lg shadow-md">
      <h3 class="text-lg font-bold text-dark mb-3">Current Cart Items</h3>
      <%
        Map<String, Integer> cart = (Map<String, Integer>) request.getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
      %>
      <ul class="space-y-2">
        <%
          for (Map.Entry<String, Integer> entry : cart.entrySet()) {
            String productId = entry.getKey();
            int qty = entry.getValue();
            com.app.grocery.model.Product p = com.app.grocery.dao.ProductDAO.findById(productId);
            if (p != null) {
        %>
        <li class="border-b pb-2 last:border-0">
          <strong class="text-dark"><%= p.getProductName() %></strong> - Qty: <%= qty %>
        </li>
        <%
            }
          }
        %>
      </ul>
      <%
      } else {
      %>
      <p class="text-gray-500">Your cart is empty.</p>
      <%
        }
      %>
    </div>
  </div>
</div>
</body>
</html>