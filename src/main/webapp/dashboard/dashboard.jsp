<%@ page import="java.util.List" %>
<%@ page import="com.app.grocery.model.Product" %>
<%@ page import="com.app.grocery.model.User" %>
<%@ page import="com.app.grocery.model.CartItem" %>

<%
    Object user = session.getAttribute("user");
    if (user == null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Required</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="relative">
<!-- Background Overlay with Blur -->
<div class="fixed inset-0 bg-black bg-opacity-30 backdrop-blur-sm z-40"></div>

<!-- Centered Login Prompt -->
<div class="fixed inset-0 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-xl p-8 max-w-md text-center border border-gray-300">
        <h2 class="text-2xl font-bold mb-4 text-red-600">OOPS !</h2>
        <p class="mb-6 text-gray-700">
            You need to
            <a href="user?action=login" class="text-blue-600 underline">Log In</a>
            or
            <a href="user?action=signup" class="text-blue-600 underline">Sign Up</a>
            to use this website.
        </p>
        <div class="flex justify-center space-x-4">
            <a href="user?action=login" class="bg-dark text-white px-4 py-2 rounded hover:bg-darkest">Login</a>
            <a href="user?action=signup" class="bg-accent text-white px-4 py-2 rounded hover:bg-darkaccent">Sign Up</a>
        </div>
    </div>
</div>
</body>
</html>
<%
        return;
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FreshMart Grocery Store</title>
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
                        darkaccent: '#768f36',
                        lightaccent: '#e8f5c8',
                    }
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .product-image {
                height: 180px;
                @apply bg-gray-100 flex justify-center items-center text-dark;
            }
            .cart-item-image {
                @apply w-20 h-20 bg-gray-100 mr-4 flex-shrink-0 flex justify-center items-center;
            }
            .cart-sidebar {
                @apply fixed top-0 right-[-400px] w-full sm:w-[400px] h-screen bg-white shadow-lg transition-all duration-300 z-50 p-6 overflow-y-auto;
            }
            .cart-sidebar.open {
                @apply right-0;
            }
            .overlay {
                @apply fixed inset-0 bg-black bg-opacity-50 z-40 hidden;
            }
            .overlay.active {
                @apply block;
            }
        }
    </style>
</head>
<body class="bg-light text-darkest">
<!-- Header -->
<header class="bg-gradient-to-r from-dark to-darkaccent text-light py-4 px-6 shadow-md">
    <div class="container mx-auto flex justify-between items-center">
        <div class="text-2xl font-bold text-accent">FreshMart</div>

        <nav class="hidden md:block">
            <ul class="flex space-x-6">
                <li><a href="dashboard" class="hover:text-lightaccent font-medium transition">Home</a></li>
            </ul>
        </nav>

        <div class="flex items-center space-x-4">
            <%
                Object userObj = session.getAttribute("user");
                if (userObj != null) {
                    User user1 = (User) userObj;// Replace with user.getName() if it's a User object
            %>
            <a href="user?action=edit&id=<%= user1.getId() %>" class="text-lightaccent font-medium hover:underline">
                Hi, <%= user1.getName() %>
            </a>

            <form action="logout" method="post">
                <button type="submit" class="bg-accent text-dark px-3 py-1 rounded hover:bg-lightaccent font-semibold transition">
                    Logout
                </button>
            </form>
            <%
                }
            %>
            <div class="cart-icon relative cursor-pointer" id="cartIcon">
                <span class="text-xl">🛒</span>
                <span class="cart-count absolute -top-2 -right-2 bg-accent text-dark rounded-full w-5 h-5 flex justify-center items-center text-xs font-bold">
                    <%= request.getAttribute("cartCount") != null ? request.getAttribute("cartCount") : 0 %>
                </span>
            </div>
        </div>
    </div>
</header>

<!-- Mobile Menu Button -->
<div class="md:hidden bg-dark text-light p-2 flex justify-center">
    <button class="mobile-menu-button px-4 py-2">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
        </svg>
    </button>
</div>

<main class="container mx-auto flex flex-col md:flex-row">
    <!-- Sidebar -->
    <aside class="w-full md:w-64 bg-gradient-to-b from-dark to-darkest text-light p-6 md:min-h-[calc(100vh-72px)]">
        <div class="categories">
            <h2 class="text-xl font-bold text-accent mb-4 border-b border-accent pb-2">Categories</h2>
            <ul class="space-y-2">
                <%
                    String selectedCategory = (String) request.getAttribute("selectedCategory");
                %>
                <li>
                    <a href="dashboard"
                       class="block px-3 py-2 rounded transition
                  <%= selectedCategory == null ? "bg-accent text-dark font-medium" : "hover:bg-accent hover:text-dark" %>">
                        All Categories
                    </a>
                </li>
                <%
                    List<String> categoryNames = (List<String>) request.getAttribute("categoryNames");
                    if (categoryNames != null) {
                        for (String name : categoryNames) {
                            boolean isSelected = name.equals(selectedCategory);
                %>
                <li>
                    <a href="dashboard?category=<%= name %>"
                       class="block px-3 py-2 rounded transition
                  <%= isSelected ? "bg-accent text-dark font-medium" : "hover:bg-accent hover:text-dark" %>">
                        <%= name %>
                    </a>
                </li>
                <%
                        }
                    }
                %>
            </ul>

        </div>
    </aside>

    <!-- Products -->
    <section class="flex-1 p-6">
        <h2 class="text-2xl font-semibold mb-6">Available Products</h2>
        <form method="get" action="dashboard" class="mb-4 flex justify-end">
            <% if (selectedCategory != null) { %>
            <input type="hidden" name="category" value="<%= selectedCategory %>">
            <% } %>
            <select name="sort" onchange="this.form.submit()"
                    class="border border-gray-300 rounded px-3 py-2">
                <option value="">Sort By</option>
                <option value="price" <%= "price".equals(request.getParameter("sort")) ? "selected" : "" %>>Price (Low to High)</option>
                <option value="category" <%= "category".equals(request.getParameter("sort")) ? "selected" : "" %>>Category (A-Z)</option>
            </select>
        </form>

        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products != null) {
                    for (Product p : products) {
            %>
            <div class="bg-white shadow-md rounded-xl p-4 hover:shadow-lg transition">
                <h3 class="text-lg font-bold mb-2"><%= p.getProductName() %></h3>
                <p class="text-sm text-gray-600 mb-1">Category: <%= p.getCategory() %></p>
                <p class="text-sm text-gray-600 mb-1">Price: <%= p.getPrice() %> LKR</p>
                <p class="text-sm text-gray-600 mb-2">Available: <%= p.getQuantity() %></p>
                <form action="cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="<%= p.getProductID() %>">
                    <button type="submit" class="bg-accent text-white px-4 py-2 rounded hover:bg-accent-dark transition">
                        Add to Cart
                    </button>
                </form>
            </div>
            <%
                    }
                }
            %>
        </div>
    </section>
</main>

<!-- Cart Sidebar -->
<div class="overlay" id="overlay"></div>

<div class="cart-sidebar" id="cartSidebar">
    <div class="cart-header flex justify-between items-center mb-6 pb-4 border-b">
        <h2 class="text-xl font-bold text-dark">Your Cart</h2>
        <button class="close-cart text-2xl text-dark hover:text-gray-600" id="closeCart">×</button>
    </div>

    <div class="cart-items space-y-4 mb-6">

        <%
            List<Product> cartItems = (List<Product>) request.getAttribute("cartItems");
            double total = 0;
            if (cartItems != null && !cartItems.isEmpty()) {
                for (Product item : cartItems) {
                    double itemTotal = item.getPrice() * item.getQuantity(); // quantity here is reused for cartQuantity
                    total += itemTotal;
        %>
        <div class="cart-item flex pb-4 border-b">
            <div class="flex-1">
                <div class="flex items-center">
                    <div class="font-semibold"><%= item.getProductName() %></div>
                    <div class="text-dark font-medium mb-2"><%= item.getPrice() %> LKR</div>
                    <div class="flex items-center">
                        <div class="quantity-control flex items-center mr-4">
                            <form action="cart" method="post" class="flex">
                                <input type="hidden" name="action" value="decrease">
                                <input type="hidden" name="productId" value="<%= item.getProductID() %>">
                                <button class="quantity-btn w-6 h-6 bg-light border border-gray-300 rounded-l">-</button>
                            </form>
                            <span class="quantity mx-2 w-8 text-center"><%= item.getQuantity() %></span>
                            <form action="cart" method="post" class="flex">
                                <input type="hidden" name="action" value="increase">
                                <input type="hidden" name="productId" value="<%= item.getProductID() %>">
                                <button class="quantity-btn w-6 h-6 bg-light border border-gray-300 rounded-r">+</button>
                            </form>
                        </div>
                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="productId" value="<%= item.getProductID() %>">
                            <button class="remove-item text-red-500 hover:text-red-700 text-sm">Remove</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%
            }
        } else {
        %>
        <p class="text-gray-600">Your cart is empty.</p>
        <%
            }
        %>
        <div class="cart-total text-right font-bold text-lg mb-6">
            Total: <%= String.format("%.2f", total) %> LKR
        </div>


    </div>

    <%
        String userName = (String) session.getAttribute("loggedInUser");
        if (userName == null) {
            userName = "guest"; // fallback
        }
    %>

    <form action="order" method="post">
        <input type="hidden" name="action" value="checkout"/>
        <input type="hidden" name="userName" value="<%= userName %>" />
        <button type="submit" class="checkout-btn w-full bg-gray-800 hover:bg-gray-900 text-white font-bold py-3 px-4 rounded transition">
            Proceed to Checkout
        </button>
    </form>


</div>

<script>
    const cartIcon = document.getElementById('cartIcon');
    const cartSidebar = document.getElementById('cartSidebar');
    const closeCart = document.getElementById('closeCart');
    const overlay = document.getElementById('overlay');

    cartIcon.addEventListener('click', () => {
        cartSidebar.classList.add('open');
        overlay.classList.add('active');
    });

    closeCart.addEventListener('click', () => {
        cartSidebar.classList.remove('open');
        overlay.classList.remove('active');
    });

    overlay.addEventListener('click', () => {
        cartSidebar.classList.remove('open');
        overlay.classList.remove('active');
    });
</script>
</body>
</html>
