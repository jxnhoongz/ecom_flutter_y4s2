import 'package:app_e_commerce/data/local/user_data_local_storage.dart';
import 'package:app_e_commerce/models/response/category.dart';
import 'package:app_e_commerce/models/response/post.dart';
import 'package:app_e_commerce/repository/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController{
  var productRepository = ProductRepositoryImpl();
  var userDataStorage = UserDataLocalStorage();

  // Reactive state variables
  var categories = <Category>[].obs;
  var posts = <Post>[].obs;
  var isLoadingCategories = false.obs;
  var isLoadingPosts = false.obs;
  var selectedCategoryId = 0.obs;
  var searchQuery = "".obs;
  var currentPage = 0.obs;
  var hasMoreData = true.obs;
  var showMyProductsOnly = false.obs;

  @override
  void onInit(){
    super.onInit();
    loadCategories();
    loadPosts();
  }

  // Load categories from API
  Future<void> loadCategories() async {
    try {
      isLoadingCategories.value = true;
      var categoriesData = await productRepository.getCategories(
        limit: 20,
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

  // Load posts from API
  Future<void> loadPosts({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 0;
        hasMoreData.value = true;
      }

      isLoadingPosts.value = true;

      // Get current user ID if filtering by "My Products"
      int userIdFilter = 0;
      if (showMyProductsOnly.value) {
        int? userId = await userDataStorage.getUserId();
        userIdFilter = userId ?? 0;
      }

      var postsData = await productRepository.getPosts(
        limit: 10,
        page: currentPage.value,
        status: "ACT",
        categoryId: selectedCategoryId.value,
        name: searchQuery.value,
        userId: userIdFilter,
      );

      if (isRefresh) {
        posts.value = postsData;
      } else {
        posts.addAll(postsData);
      }

      // Check if there's more data
      if (postsData.length < 10) {
        hasMoreData.value = false;
      }
    } catch (e) {
      showErrorMessage("Failed to load posts: $e");
    } finally {
      isLoadingPosts.value = false;
    }
  }

  // Load more posts (pagination)
  Future<void> loadMorePosts() async {
    if (!isLoadingPosts.value && hasMoreData.value) {
      currentPage.value++;
      await loadPosts();
    }
  }

  // Refresh data (pull-to-refresh)
  Future<void> refreshData() async {
    await Future.wait([
      loadCategories(),
      loadPosts(isRefresh: true),
    ]);
  }

  // Filter by category
  void filterByCategory(int categoryId) {
    print('Filtering by category ID: $categoryId');
    selectedCategoryId.value = categoryId;
    loadPosts(isRefresh: true);
  }

  // Search posts
  void searchPosts(String query) {
    searchQuery.value = query;
    loadPosts(isRefresh: true);
  }

  // Toggle "My Products" filter
  void toggleMyProducts() {
    showMyProductsOnly.value = !showMyProductsOnly.value;
    loadPosts(isRefresh: true);
  }

  // Logout
  Future<void> logout() async {
    await userDataStorage.clearUserData();
    Get.offAllNamed("/login");
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