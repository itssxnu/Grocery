<%@ page import="com.app.grocery.model.User" %>
<%
  User u = (User) request.getAttribute("user");
%>
<html>
<head>
  <title>User Form</title>
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
  <div class="flex justify-between items-center mb-6">
    <h2 class="text-2xl font-bold text-dark"><%= (u == null ? "Add New User" : "Edit User") %></h2>
    <a href="dashboard" class="bg-dark hover:bg-darkest text-white font-bold py-2 px-4 rounded">Back to Dashboard</a>
  </div>

  <form method="post" action="user" class="space-y-4">
    <input type="hidden" name="id" value="<%= (u != null ? u.getId() : "") %>"/>

    <div>
      <label class="block text-dark font-medium mb-1">Name</label>
      <input type="text" name="name" value="<%= (u != null ? u.getName() : "") %>" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Email</label>
      <input type="email" name="email" value="<%= (u != null ? u.getEmail() : "") %>" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Phone</label>
      <input type="text" name="phone" value="<%= (u != null ? u.getPhone() : "") %>" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Address</label>
      <input type="text" name="address" value="<%= (u != null ? u.getAddress() : "") %>" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <div>
      <label class="block text-dark font-medium mb-1">Password</label>
      <input type="password" name="password" value="<%= (u != null ? u.getPassword() : "") %>" required
             class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
    </div>

    <button type="submit" class="w-full bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded transition">
      <%= (u != null ? "Update" : "Add") %> User
    </button>
  </form>
</div>
</body>
</html>