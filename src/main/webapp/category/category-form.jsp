<html>
<head>
    <title>Category Form</title>
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
    <h2 class="text-2xl font-bold text-dark mb-4"><%= request.getAttribute("category") == null ? "Add New Category" : "Edit Category" %></h2>
    <form method="post" action="category" class="space-y-4">
        <input type="hidden" name="action" value="<%= request.getAttribute("category") == null ? "add" : "edit" %>" />
        <input type="hidden" name="id" value="<%= request.getAttribute("category") != null ? ((com.app.grocery.model.Category) request.getAttribute("category")).getId() : "" %>" />

        <div>
            <label class="block text-dark font-medium mb-1">Name</label>
            <input type="text" name="name"
                   value="<%= request.getAttribute("category") != null ? ((com.app.grocery.model.Category) request.getAttribute("category")).getName() : "" %>"
                   required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
        </div>

        <div>
            <label class="block text-dark font-medium mb-1">Description</label>
            <input type="text" name="description"
                   value="<%= request.getAttribute("category") != null ? ((com.app.grocery.model.Category) request.getAttribute("category")).getDescription() : "" %>"
                   required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
        </div>

        <button type="submit" class="w-full bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded transition">
            Save
        </button>
    </form>
</div>
</body>
</html>