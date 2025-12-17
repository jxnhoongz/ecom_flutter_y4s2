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
  var isEditing = false.obs;
  Category? editingCategory;

  // Text editing controller
  final categoryNameController = TextEditingController();

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
      // Filter out deleted categories (backend sets name to null instead of deleting)
      categories.value = categoriesData.where((cat) => cat.name != null && cat.name!.isNotEmpty).toList();
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
        categoryNameController.clear();
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

  // Start editing a category
  void startEditCategory(Category category) {
    isEditing.value = true;
    editingCategory = category;
    categoryNameController.text = category.name ?? '';
  }

  // Cancel editing
  void cancelEdit() {
    isEditing.value = false;
    editingCategory = null;
    categoryNameController.clear();
  }

  // Update existing category
  Future<void> updateCategory() async {
    if (editingCategory == null) return;

    if (categoryNameController.text.trim().isEmpty) {
      showErrorMessage("Category name cannot be empty");
      return;
    }

    try {
      isCreating.value = true;
      var updatedCategory = await productRepository.updateCategory(
        id: editingCategory!.id!,
        name: categoryNameController.text.trim(),
        status: editingCategory!.status ?? "ACT",
      );

      if (updatedCategory != null) {
        showSuccessMessage("Category '${updatedCategory.name}' updated successfully!");
        cancelEdit();
        await loadCategories(); // Reload categories
      } else {
        showErrorMessage("Failed to update category");
      }
    } catch (e) {
      showErrorMessage("Error updating category: $e");
    } finally {
      isCreating.value = false;
    }
  }

  // Confirm before deleting category
  void confirmDeleteCategory(Category category) {
    Get.defaultDialog(
      title: "Delete Category",
      middleText: "Are you sure you want to delete '${category.name}'?",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close dialog
        deleteCategory(category.id!);
      },
    );
  }

  // Delete category
  Future<void> deleteCategory(int id) async {
    try {
      isLoading.value = true;
      var success = await productRepository.deleteCategory(id);

      if (success) {
        showSuccessMessage("Category deleted successfully");
        await loadCategories(); // Reload categories
      } else {
        showErrorMessage("Failed to delete category");
      }
    } catch (e) {
      showErrorMessage("Error deleting category: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    categoryNameController.dispose();
    super.onClose();
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
