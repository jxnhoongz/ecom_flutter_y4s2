import 'dart:io';
import 'package:app_e_commerce/models/response/category.dart';
import 'package:app_e_commerce/repository/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ManageProductViewModel extends GetxController {
  var productRepository = ProductRepositoryImpl();
  final ImagePicker _imagePicker = ImagePicker();

  // Reactive state variables
  var categories = <Category>[].obs;
  var selectedCategoryId = Rx<int?>(null);
  var selectedImage = Rx<File?>(null);
  var isLoadingCategories = false.obs;
  var isCreating = false.obs;
  var isUploadingImage = false.obs;

  @override
  void onInit() {
    super.onInit();
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

      // Auto-select first category if available
      if (categories.isNotEmpty && selectedCategoryId.value == null) {
        selectedCategoryId.value = categories.first.id;
      }
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
      }
    } catch (e) {
      showErrorMessage("Failed to take photo: $e");
    }
  }

  // Remove selected image
  void removeImage() {
    selectedImage.value = null;
  }

  // Create new product
  Future<void> createProduct(String title, String description) async {
    if (title.trim().isEmpty) {
      showErrorMessage("Product title cannot be empty");
      return;
    }

    if (description.trim().isEmpty) {
      showErrorMessage("Product description cannot be empty");
      return;
    }

    if (selectedCategoryId.value == null) {
      showErrorMessage("Please select a category");
      return;
    }

    try {
      isCreating.value = true;

      // Upload image first if selected
      String? imageFilename;
      if (selectedImage.value != null) {
        isUploadingImage.value = true;
        imageFilename = await productRepository.uploadImage(selectedImage.value!);
        isUploadingImage.value = false;

        if (imageFilename == null) {
          showErrorMessage("Failed to upload image");
          return;
        }
      }

      // Create product with image filename
      var newProduct = await productRepository.createPost(
        title: title.trim(),
        description: description.trim(),
        categoryId: selectedCategoryId.value!,
        image: imageFilename,
        status: "ACT",
      );

      if (newProduct != null) {
        showSuccessMessage("Product '${newProduct.title}' created successfully!");

        // Clear form
        selectedImage.value = null;

        // Navigate back to home
        Get.back();

        // Refresh home page
        Get.toNamed('/');
      } else {
        showErrorMessage("Failed to create product");
      }
    } catch (e) {
      showErrorMessage("Error creating product: $e");
    } finally {
      isCreating.value = false;
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
}
