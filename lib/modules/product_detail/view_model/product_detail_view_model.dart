import 'package:app_e_commerce/models/response/post.dart';
import 'package:app_e_commerce/repository/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailViewModel extends GetxController {
  var productRepository = ProductRepositoryImpl();

  // Reactive state variables
  var post = Rx<Post?>(null);
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = "".obs;

  // Load product detail by ID
  Future<void> loadProductDetail(int productId) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      var productData = await productRepository.getPostById(productId);

      if (productData != null) {
        post.value = productData;
      } else {
        hasError.value = true;
        errorMessage.value = "Product not found";
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "Failed to load product: $e";
      showErrorMessage("Failed to load product details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Show error message
  void showErrorMessage(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    );
  }
}
