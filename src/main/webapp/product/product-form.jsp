<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.app.grocery.model.Product" %>
<%@ page import="java.util.List" %>
<%
  Product product = (Product) request.getAttribute("product");
  boolean isEdit = product != null;
%>
<html>
<head>
  <title><%= isEdit ? "Edit" : "Add" %> Product</title>
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
<div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-md">
  <h2 class="text-2xl font-bold text-dark mb-4"><%= isEdit ? "Edit" : "Add" %> Product</h2>
  <form action="product" method="post" class="space-y-4">
    <% if (isEdit) { %>
    <input type="hidden" name="id" value="<%= product.getProductID() %>"/>
    <% } %>

    <div>
      <label class="block text-dark font-medium mb-1">Name</label>
      <input type="text" name="productName"
             value="<%= isEdit ? product.getProductName() : "" %>"
             required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Category</label>
      <select name="category" required class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent">
        <option value="">Select Category</option>
        <% List<String> categories = (List<String>) request.getAttribute("categories");
          String selectedCategory = isEdit ? product.getCategory() : "";
          for (String cat : categories) {
        %>
        <option value="<%= cat %>" <%= cat.equals(selectedCategory) ? "selected" : "" %>><%= cat %></option>
        <% } %>
      </select>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Price</label>
      <input type="number" step="0.01" name="price"
             value="<%= isEdit ? product.getPrice() : "" %>"
             required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Quantity</label>
      <input type="number" name="quantity"
             value="<%= isEdit ? product.getQuantity() : "" %>"
             required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <button type="submit" class="w-full bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded transition">
      <%= isEdit ? "Update" : "Add" %>
    </button>
  </form>

  <a href="product" class="inline-block mt-4 text-accent hover:text-dark">Back to list</a>
</div>
</body>
</html>