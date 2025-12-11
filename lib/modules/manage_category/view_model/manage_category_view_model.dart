import 'package:app_e_commerce/models/response/category.dart';
import 'package:app_e_commerce/repository/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageCategoryViewModel extends GetxController {
  var productRepository = ProductRepositoryImpl();

  // Reactive state variables
  var categories = <Category>[].obs;
  var isLoading = false.obs;
  var isCreating = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  // Load categories from API
  Future<void> loadCategories() async {
    try {
      isLoading.value = true;
      var categoriesData = await productRepository.getCategories(
        limit: 50,
        page: 0,
        status: "ACT",
      );
      categories.value = categoriesData;
    } catch (e) {
      showErrorMessage("Failed to load categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Create new category
  Future<void> createCategory(String name) async {
    if (name.trim().isEmpty) {
      showErrorMessage("Category name cannot be empty");
      return;
    }

    try {
      isCreating.value = true;
      var newCategory = await productRepository.createCategory(
        name: name.trim(),
        status: "ACT",
      );

      if (newCategory != null) {
        showSuccessMessage("Category '${newCategory.name}' created successfully!");
        await loadCategories(); // Reload categories
      } else {
        showErrorMessage("Failed to create category");
      }
    } catch (e) {
      showErrorMessage("Error creating category: $e");
    } finally {
      isCreating.value = false;
    }
  }

  // Show error message
  void showErrorMessage(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    );
  }

  // Show success message
  void showSuccessMessage(String message) {
    Get.snackbar(
      "Success",
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    );
  }
}
