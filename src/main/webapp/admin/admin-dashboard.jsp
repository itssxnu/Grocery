<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
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
<div class="max-w-4xl mx-auto bg-white shadow-lg p-6 rounded-lg">
  <!-- Logout Button -->
  <form action="logout" method="post" class="absolute top-6 right-6">
    <button type="submit" class="bg-dark text-light px-4 py-2 rounded hover:bg-accent transition">
      Logout
    </button>
  </form>
  <h1 class="text-3xl font-bold text-dark mb-8">Admin Dashboard</h1>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
    <a href="product?action=view" class="block p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-accent hover:text-white transition">
      <h5 class="mb-2 text-xl font-bold tracking-tight">Products</h5>
      <p class="font-normal">Manage all products in the store</p>
    </a>
    <a href="category?action=view" class="block p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-accent hover:text-white transition">
      <h5 class="mb-2 text-xl font-bold tracking-tight">Categories</h5>
      <p class="font-normal">Manage product categories</p>
    </a>
    <a href="user" class="block p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-accent hover:text-white transition">
      <h5 class="mb-2 text-xl font-bold tracking-tight">Users</h5>
      <p class="font-normal">Manage user accounts</p>
    </a>
    <a href="payment?action=view" class="block p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-accent hover:text-white transition">
      <h5 class="mb-2 text-xl font-bold tracking-tight">Payments</h5>
      <p class="font-normal">View payment histories</p>
    </a>
    <a href="order?action=view" class="block p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-accent hover:text-white transition">
      <h5 class="mb-2 text-xl font-bold tracking-tight">Orders</h5>
      <p class="font-normal">View order histories</p>
    </a>
  </div>
</div>
</body>
</html>