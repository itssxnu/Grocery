<%@ page import="com.app.grocery.model.Category" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Categories</title>
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
        <h2 class="text-2xl font-bold text-dark">Categories</h2>
        <a href="admin-dashboard" class="bg-dark hover:bg-darkest text-white font-bold py-2 px-4 rounded">Back to Dashboard</a>
    </div>
    <a href="category?action=add" class="inline-block bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded mb-4">Add New Category</a>

    <div class="overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg overflow-hidden">
            <thead class="bg-dark text-light">
            <tr>
                <th class="py-3 px-4 text-left">Name</th>
                <th class="py-3 px-4 text-left">Description</th>
                <th class="py-3 px-4 text-left">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
            <% for (com.app.grocery.model.Category category : (List<Category>) request.getAttribute("categories")) { %>
            <tr class="hover:bg-gray-50">
                <td class="py-3 px-4"><%= category.getName() %></td>
                <td class="py-3 px-4"><%= category.getDescription() %></td>
                <td class="py-3 px-4">
                    <a href="category?action=edit&id=<%= category.getId() %>" class="text-accent hover:text-dark mr-2">Edit</a>
                    <a href="category?action=delete&id=<%= category.getId() %>" class="text-red-500 hover:text-red-700">Delete</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>