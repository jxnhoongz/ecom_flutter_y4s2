import 'package:app_e_commerce/service/constant_uri.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/product_detail_view_model.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final productDetailViewModel = Get.put(ProductDetailViewModel());
  int? productId;

  @override
  void initState() {
    super.initState();
    // Get product ID from route arguments and load detail
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (productId != null) {
        productDetailViewModel.loadProductDetail(productId!);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get arguments when dependencies change (route is ready)
    if (productId == null && Get.arguments != null) {
      productId = Get.arguments as int;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final int productId = Get.arguments as int;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: colorScheme.onPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: colorScheme.onPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (productDetailViewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (productDetailViewModel.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  productDetailViewModel.errorMessage.value,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => productDetailViewModel.loadProductDetail(productId),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        final post = productDetailViewModel.post.value;
        if (post == null) {
          return Center(child: Text('Product not found'));
        }

        // Build image URL
        String? imageUrl;
        if (post.image != null && post.image!.isNotEmpty) {
          imageUrl = '${ConstantUri.imageBasePath}?filename=${post.image}';
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 300,
                width: double.infinity,
                color: colorScheme.surfaceContainerHighest,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 100,
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
                      )
                    : Center(
                        child: Icon(
                          Icons.shopping_bag,
                          size: 100,
                          color: colorScheme.primary,
                        ),
                      ),
              ),

              // Product Info Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    if (post.category?.name != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          post.category!.name!,
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),

                    SizedBox(height: 12),

                    // Product Title
                    Text(
                      post.title ?? 'No title',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 12),

                    // Views and Date
                    Row(
                      children: [
                        Icon(Icons.visibility, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '${post.totalView ?? 0} views',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          post.createAt ?? 'N/A',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // Divider
                    Divider(),

                    SizedBox(height: 16),

                    // Description Header
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 12),

                    // Description Content
                    Text(
                      post.description ?? 'No description available',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 24),

                    // Divider
                    Divider(),

                    SizedBox(height: 16),

                    // Seller Info (if user data available)
                    if (post.user != null) ...[
                      Text(
                        'Seller Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: colorScheme.primary,
                              child: Text(
                                (post.user?.username ?? 'U')[0].toUpperCase(),
                                style: TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.user?.username ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  if (post.user?.email != null)
                                    Text(
                                      post.user!.email!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  if (post.user?.phoneNumber != null)
                                    Text(
                                      post.user!.phoneNumber!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: colorScheme.primary),
                ),
                child: Text(
                  'Contact Seller',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: colorScheme.primary,
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
