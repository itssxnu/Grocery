<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.app.grocery.model.Product" %>
<%
  List<Product> products = (List<Product>) request.getAttribute("products");
%>
<html>
<head>
  <title>Product List</title>
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
    <h2 class="text-2xl font-bold text-dark">Product List</h2>
    <a href="admin-dashboard" class="bg-dark hover:bg-darkest text-white font-bold py-2 px-4 rounded">Back to Dashboard</a>
  </div>
  <a href="product?action=add" class="inline-block bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded mb-4">Add New Product</a>

  <form method="get" action="product" class="mb-6">
    <label for="sortBy" class="block text-dark font-medium mb-2">Sort by:</label>
    <div class="flex">
      <select name="sortBy" id="sortBy" onchange="this.form.submit()" class="border border-dark rounded-l px-4 py-2 focus:outline-none focus:ring-2 focus:ring-accent">
        <option value="">-- Select --</option>
        <option value="category" <%= "category".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Category</option>
        <option value="price" <%= "price".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Price</option>
      </select>
      <input type="hidden" name="action" value="list"/>
    </div>
  </form>

  <div class="overflow-x-auto">
    <table class="min-w-full bg-white rounded-lg overflow-hidden">
      <thead class="bg-dark text-light">
      <tr>
        <th class="py-3 px-4 text-left">Name</th>
        <th class="py-3 px-4 text-left">Category</th>
        <th class="py-3 px-4 text-left">Price</th>
        <th class="py-3 px-4 text-left">Quantity</th>
        <th class="py-3 px-4 text-left">Actions</th>
      </tr>
      </thead>
      <tbody class="divide-y divide-gray-200">
      <% for (Product p : products) { %>
      <tr class="hover:bg-gray-50">
        <td class="py-3 px-4"><%= p.getProductName() %></td>
        <td class="py-3 px-4"><%= p.getCategory() %></td>
        <td class="py-3 px-4"><%= p.getPrice() %> LKR</td>
        <td class="py-3 px-4"><%= p.getQuantity() %></td>
        <td class="py-3 px-4">
          <a href="product?action=edit&id=<%= p.getProductID() %>" class="text-accent hover:text-dark mr-2">Edit</a>
          <a href="product?action=delete&id=<%= p.getProductID() %>" class="text-red-500 hover:text-red-700">Delete</a>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>