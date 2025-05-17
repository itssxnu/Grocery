<%@ page import="java.util.*, com.app.grocery.model.User" %>
<html>
<head>
    <title>User List</title>
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
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-bold text-dark">All Users</h2>
        <div class="flex space-x-4">
            <a href="user?action=add" class="bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded">Add User</a>
            <a href="admin-dashboard" class="bg-dark hover:bg-darkest text-white font-bold py-2 px-4 rounded">Back to Dashboard</a>
        </div>
    </div>

    <div class="overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg overflow-hidden">
            <thead class="bg-dark text-light">
            <tr>
                <th class="py-3 px-4 text-left">Name</th>
                <th class="py-3 px-4 text-left">Email</th>
                <th class="py-3 px-4 text-left">Phone</th>
                <th class="py-3 px-4 text-left">Address</th>
                <th class="py-3 px-4 text-left">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                for (User u : users) {
            %>
            <tr class="hover:bg-gray-50">
                <td class="py-3 px-4"><%= u.getName() %></td>
                <td class="py-3 px-4"><%= u.getEmail() %></td>
                <td class="py-3 px-4"><%= u.getPhone() %></td>
                <td class="py-3 px-4"><%= u.getAddress() %></td>
                <td class="py-3 px-4">
                    <a href="user?action=edit&id=<%= u.getId() %>" class="text-accent hover:text-dark mr-3">Edit</a>
                    <a href="user?action=delete&id=<%= u.getId() %>" class="text-red-500 hover:text-red-700">Delete</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>