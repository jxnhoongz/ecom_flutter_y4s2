import 'package:app_e_commerce/data/local/user_data_local_storage.dart';
import 'package:app_e_commerce/models/response/post.dart';
import 'package:app_e_commerce/repository/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailViewModel extends GetxController {
  var productRepository = ProductRepositoryImpl();
  final userDataStorage = UserDataLocalStorage();

  // Reactive state variables
  var post = Rx<Post?>(null);
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = "".obs;
  var isOwner = false.obs;

  // Load product detail by ID
  Future<void> loadProductDetail(int productId) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      var productData = await productRepository.getPostById(productId);

      if (productData != null) {
        post.value = productData;
        await checkOwnership();
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

  // Check if current user owns this product
  Future<void> checkOwnership() async {
    try {
      int? currentUserId = await userDataStorage.getUserId();
      isOwner.value = (post.value?.user?.id == currentUserId);
    } catch (e) {
      isOwner.value = false;
    }
  }

  // Navigate to edit product page
  void navigateToEditProduct() {
    if (post.value != null) {
      Get.toNamed('/edit-product', arguments: post.value);
    }
  }

  // Confirm before deleting product
  void confirmDeleteProduct() {
    if (post.value == null) return;

    Get.defaultDialog(
      title: "Delete Product",
      middleText: "Are you sure you want to delete '${post.value!.title}'? This cannot be undone.",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close dialog
        deleteProduct(post.value!.id!);
      },
    );
  }

  // Delete product
  Future<void> deleteProduct(int id) async {
    try {
      isLoading.value = true;
      var success = await productRepository.deletePost(id);

      if (success) {
        Get.back(); // Return to previous page
        Get.snackbar(
          "Success",
          "Product deleted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        );
      } else {
        showErrorMessage("Failed to delete product");
      }
    } catch (e) {
      showErrorMessage("Error deleting product: $e");
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
