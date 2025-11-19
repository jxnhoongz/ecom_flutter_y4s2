import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_mode/home_view_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeViewModel = Get.put(HomeViewModel());

  // Mock product data
  final List<Map<String, dynamic>> mockProducts = const [
    {
      'name': 'Wireless Headphones',
      'price': 79.99,
      'image': Icons.headphones,
      'rating': 4.5,
    },
    {
      'name': 'Smart Watch',
      'price': 199.99,
      'image': Icons.watch,
      'rating': 4.8,
    },
    {
      'name': 'Running Shoes',
      'price': 129.99,
      'image': Icons.directions_run,
      'rating': 4.3,
    },
    {
      'name': 'Backpack',
      'price': 49.99,
      'image': Icons.backpack,
      'rating': 4.6,
    },
    {
      'name': 'Sunglasses',
      'price': 89.99,
      'image': Icons.wb_sunny,
      'rating': 4.4,
    },
    {
      'name': 'Camera',
      'price': 599.99,
      'image': Icons.camera_alt,
      'rating': 4.9,
    },
    {
      'name': 'Laptop Stand',
      'price': 39.99,
      'image': Icons.laptop,
      'rating': 4.2,
    },
    {
      'name': 'Water Bottle',
      'price': 24.99,
      'image': Icons.local_drink,
      'rating': 4.7,
    },
  ];

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Electronics', 'icon': Icons.devices},
    {'name': 'Fashion', 'icon': Icons.checkroom},
    {'name': 'Sports', 'icon': Icons.sports_basketball},
    {'name': 'Home', 'icon': Icons.home},
    {'name': 'Books', 'icon': Icons.book},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.primary,
        title: Text(
          'ShopEase',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: colorScheme.onPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: colorScheme.onPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout, color: colorScheme.onPrimary),
            onPressed: () {
              Get.offAllNamed("/login");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              color: colorScheme.primary,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // Banner/Promo Section
            Container(
              margin: const EdgeInsets.all(16),
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Icon(
                      Icons.local_offer,
                      size: 100,
                      color: colorScheme.onPrimary.withValues(alpha: 0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Special Offer',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Get 20% off on all items',
                          style: TextStyle(
                            color: colorScheme.onPrimary.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Shop Now',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Categories
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.shadow.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            categories[index]['icon'],
                            color: colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          categories[index]['name'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Products Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),

            // Product Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: mockProducts.length,
              itemBuilder: (context, index) {
                return _buildProductCard(mockProducts[index], colorScheme);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        backgroundColor: colorScheme.surface,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Placeholder
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Icon(
                  product['image'],
                  size: 48,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          // Product Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product['price']}',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          Text(
                            '${product['rating']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
