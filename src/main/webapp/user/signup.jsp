<html>
<head>
    <title>Signup</title>
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
<body class="bg-light min-h-screen flex items-center justify-center p-4">
<div class="max-w-md w-full bg-white p-8 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold text-dark mb-6 text-center">Sign Up</h2>
    <form method="post" action="user" class="space-y-4">
        <input type="hidden" name="action" value="signup" />

        <div>
            <label class="block text-dark font-medium mb-1">Name</label>
            <input type="text" name="name" required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
        </div>

        <div>
            <label class="block text-dark font-medium mb-1">Email</label>
            <input type="email" name="email" required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
        </div>

        <div>
            <label class="block text-dark font-medium mb-1">Phone</label>
            <input type="text" name="phone" required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
        </div>

        <div>
            <label class="block text-dark font-medium mb-1">Address</label>
            <input type="text" name="address" required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
        </div>

        <div>
            <label class="block text-dark font-medium mb-1">Password</label>
            <input type="password" name="password" required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-accent"/>
        </div>

        <button type="submit" class="w-full bg-accent hover:bg-dark text-white font-bold py-2 px-4 rounded transition">
            Sign Up
        </button>

        <% if (request.getAttribute("error") != null) { %>
        <p class="text-red-500 text-center"><%= request.getAttribute("error") %></p>
        <% } %>
    </form>

    <div class="mt-4 text-center">
        <a href="user?action=login" class="text-accent hover:text-dark">Already have an account? Login</a>
    </div>
</div>
</body>
</html>