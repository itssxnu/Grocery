<%@ page import="com.app.grocery.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.app.grocery.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Create/Edit Order</title>
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
  <h2 class="text-2xl font-bold text-dark mb-4">Create/Edit Order</h2>
  <form method="post" action="order" class="space-y-4">
    <input type="hidden" name="id" value="<%= request.getAttribute("order") != null ? ((Order)request.getAttribute("order")).getOrderId() : "" %>"/>

    <div>
      <label class="block text-dark font-medium mb-1">User Name</label>
      <input type="text" name="userName" required
             value="<%= request.getAttribute("order") != null ? ((Order)request.getAttribute("order")).getUserName() : "" %>"
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Product</label>
      <select name="productName" class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent">
        <%
          List<String> productNames = (List<String>) request.getAttribute("productNames");
          String selectedProduct = request.getAttribute("order") != null
                  ? ((Order) request.getAttribute("order")).getProductName()
                  : "";

          for (String pname : productNames) {
        %>
        <option value="<%= pname %>" <%= pname.equals(selectedProduct) ? "selected" : "" %>>
          <%= pname %>
        </option>
        <%
          }
        %>
      </select>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Quantity</label>
      <input type="number" name="quantity" required min="1"
             value="<%= request.getAttribute("order") != null ? ((Order)request.getAttribute("order")).getQuantity() : "" %>"
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Status</label>
      <select name="status" required class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent">
        <option value="pending" ${'pending' == selectedStatus ? 'selected' : ''}>Pending</option>
        <option value="completed" ${'completed' == selectedStatus ? 'selected' : ''}>Completed</option>
        <option value="canceled" ${'canceled' == selectedStatus ? 'selected' : ''}>Canceled</option>
      </select>
    </div>

    <button type="submit" class="w-full bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded transition">
      Submit
    </button>
  </form>
</div>
</body>
</html>