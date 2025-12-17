import 'dart:io';
import 'package:app_e_commerce/models/response/category.dart';
import 'package:app_e_commerce/models/response/post.dart';
import 'package:app_e_commerce/repository/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProductViewModel extends GetxController {
  var productRepository = ProductRepositoryImpl();
  final ImagePicker _imagePicker = ImagePicker();

  // Product to edit
  late Post product;

  // Text controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Reactive state variables
  var categories = <Category>[].obs;
  var selectedCategoryId = Rx<int?>(null);
  var selectedImage = Rx<File?>(null);
  var existingImageUrl = ''.obs;
  var hasNewImage = false.obs;
  var isLoadingCategories = false.obs;
  var isUpdating = false.obs;
  var isUploadingImage = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Get product from arguments
    product = Get.arguments as Post;

    // Pre-fill form with existing data
    titleController.text = product.title ?? '';
    descriptionController.text = product.description ?? '';
    selectedCategoryId.value = product.category?.id;
    existingImageUrl.value = product.image ?? '';

    loadCategories();
  }

  // Load categories from API
  Future<void> loadCategories() async {
    try {
      isLoadingCategories.value = true;
      var categoriesData = await productRepository.getCategories(
        limit: 50,
        page: 0,
        status: "ACT",
      );
      categories.value = categoriesData;
    } catch (e) {
      showErrorMessage("Failed to load categories: $e");
    } finally {
      isLoadingCategories.value = false;
    }
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        hasNewImage.value = true;
      }
    } catch (e) {
      showErrorMessage("Failed to pick image: $e");
    }
  }

  // Pick image from camera
  Future<void> takePhoto() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        hasNewImage.value = true;
      }
    } catch (e) {
      showErrorMessage("Failed to take photo: $e");
    }
  }

  // Remove selected image (keep existing or remove completely)
  void removeImage() {
    selectedImage.value = null;
    hasNewImage.value = false;
    existingImageUrl.value = '';
  }

  // Keep current image
  void keepCurrentImage() {
    selectedImage.value = null;
    hasNewImage.value = false;
  }

  // Update product
  Future<void> updateProduct() async {
    if (titleController.text.trim().isEmpty) {
      showErrorMessage("Product title cannot be empty");
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      showErrorMessage("Product description cannot be empty");
      return;
    }

    if (selectedCategoryId.value == null) {
      showErrorMessage("Please select a category");
      return;
    }

    try {
      isUpdating.value = true;

      // Determine which image to use
      String? imageFilename;
      if (hasNewImage.value && selectedImage.value != null) {
        // Upload new image
        isUploadingImage.value = true;
        imageFilename = await productRepository.uploadImage(selectedImage.value!);
        isUploadingImage.value = false;

        if (imageFilename == null) {
          showErrorMessage("Failed to upload image");
          return;
        }
      } else if (existingImageUrl.value.isNotEmpty) {
        // Keep existing image
        imageFilename = existingImageUrl.value;
      }

      // Update product
      var updatedProduct = await productRepository.updatePost(
        id: product.id!,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        categoryId: selectedCategoryId.value!,
        image: imageFilename,
        status: product.status ?? "ACT",
      );

      if (updatedProduct != null) {
        showSuccessMessage("Product '${updatedProduct.title}' updated successfully!");

        // Navigate back to detail page
        Get.back();

        // Optionally navigate back to home to refresh
        Get.offAllNamed('/');
      } else {
        showErrorMessage("Failed to update product");
      }
    } catch (e) {
      showErrorMessage("Error updating product: $e");
    } finally {
      isUpdating.value = false;
      isUploadingImage.value = false;
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

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
