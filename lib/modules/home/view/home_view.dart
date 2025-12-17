import 'package:app_e_commerce/service/constant_uri.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_mode/home_view_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeViewModel = Get.put(HomeViewModel());

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
              homeViewModel.logout();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: homeViewModel.refreshData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                color: colorScheme.primary,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  onChanged: (value) {
                    // Debounce search
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (value == homeViewModel.searchQuery.value) {
                        homeViewModel.searchPosts(value);
                      }
                    });
                    homeViewModel.searchQuery.value = value;
                  },
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

              // Categories from API
              Obx(() {
                if (homeViewModel.isLoadingCategories.value) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (homeViewModel.categories.isEmpty) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: Text('No categories available')),
                  );
                }

                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: homeViewModel.categories.length + 1, // +1 for "All" category
                    itemBuilder: (context, index) {
                      // Add "All" category at the beginning
                      if (index == 0) {
                        return Obx(() => GestureDetector(
                          onTap: () => homeViewModel.filterByCategory(0),
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: homeViewModel.selectedCategoryId.value == 0
                                        ? colorScheme.primaryContainer
                                        : colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: homeViewModel.selectedCategoryId.value == 0
                                        ? Border.all(color: colorScheme.primary, width: 2)
                                        : null,
                                    boxShadow: [
                                      BoxShadow(
                                        color: colorScheme.shadow.withValues(alpha: 0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.apps,
                                    color: colorScheme.primary,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'All',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: homeViewModel.selectedCategoryId.value == 0
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: colorScheme.onSurface,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ));
                      }

                      final category = homeViewModel.categories[index - 1];
                      return Obx(() => GestureDetector(
                        onTap: () => homeViewModel.filterByCategory(category.id ?? 0),
                        child: Container(
                          width: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: homeViewModel.selectedCategoryId.value == category.id
                                      ? colorScheme.primaryContainer
                                      : colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: homeViewModel.selectedCategoryId.value == category.id
                                      ? Border.all(color: colorScheme.primary, width: 2)
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme.shadow.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.category,
                                  color: colorScheme.primary,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: homeViewModel.selectedCategoryId.value == category.id
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                  ),
                );
              }),

              // Products Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                      homeViewModel.showMyProductsOnly.value
                          ? 'My Products'
                          : 'Popular Products',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    )),
                    Obx(() => FilterChip(
                      label: Text(
                        homeViewModel.showMyProductsOnly.value
                            ? 'Show All'
                            : 'My Products',
                        style: TextStyle(
                          fontSize: 12,
                          color: homeViewModel.showMyProductsOnly.value
                              ? colorScheme.onPrimary
                              : colorScheme.primary,
                        ),
                      ),
                      selected: homeViewModel.showMyProductsOnly.value,
                      onSelected: (_) => homeViewModel.toggleMyProducts(),
                      selectedColor: colorScheme.primary,
                      checkmarkColor: colorScheme.onPrimary,
                      backgroundColor: colorScheme.surface,
                      side: BorderSide(color: colorScheme.primary),
                    )),
                  ],
                ),
              ),

              // Product Grid from API
              Obx(() {
                if (homeViewModel.isLoadingPosts.value && homeViewModel.posts.isEmpty) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (homeViewModel.posts.isEmpty) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Text('No products available')),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: homeViewModel.posts.length,
                  itemBuilder: (context, index) {
                    final post = homeViewModel.posts[index];
                    return _buildProductCard(post, colorScheme);
                  },
                );
              }),

              // Load More Button
              Obx(() {
                if (homeViewModel.hasMoreData.value && homeViewModel.posts.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: homeViewModel.isLoadingPosts.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: homeViewModel.loadMorePosts,
                              child: const Text('Load More'),
                            ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show menu with both options
          showModalBottomSheet(
            context: context,
            backgroundColor: colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.category, color: colorScheme.primary),
                      title: const Text('Create Category'),
                      subtitle: const Text('Add a new category'),
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed('/manage-category');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(Icons.add_shopping_cart, color: colorScheme.primary),
                      title: const Text('Create Product'),
                      subtitle: const Text('Add a new product'),
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed('/create-product');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        backgroundColor: colorScheme.surface,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Home - already here
              break;
            case 1:
              // Categories - navigate to manage categories
              Get.toNamed('/manage-category');
              break;
            case 2:
              // Wishlist - not implemented yet
              Get.snackbar(
                'Coming Soon',
                'Wishlist feature will be available soon!',
                backgroundColor: colorScheme.primary,
                colorText: colorScheme.onPrimary,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              );
              break;
            case 3:
              // Profile - not implemented yet
              Get.snackbar(
                'Coming Soon',
                'Profile feature will be available soon!',
                backgroundColor: colorScheme.primary,
                colorText: colorScheme.onPrimary,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              );
              break;
          }
        },
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

  Widget _buildProductCard(dynamic post, ColorScheme colorScheme) {
    // Build image URL - filter out invalid placeholders
    String? imageUrl;
    if (post.image != null &&
        post.image!.isNotEmpty &&
        post.image != 'NON' &&
        post.image != 'NONE' &&
        !post.image!.trim().isEmpty) {
      imageUrl = '${ConstantUri.imageBasePath}?filename=${post.image}';
    }

    return GestureDetector(
      onTap: () {
        // Navigate to product detail page with product ID
        if (post.id != null) {
          Get.toNamed('/product-detail', arguments: post.id);
        }
      },
      child: Container(
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
          // Product Image
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: imageUrl != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 48,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.shopping_bag,
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
                    post.title ?? 'No title',
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
                        post.category?.name ?? 'Uncategorized',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${post.totalView ?? 0}',
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
      ),
    );
  }
}
