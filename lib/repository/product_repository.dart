import 'dart:io';
import 'package:app_e_commerce/models/response/category.dart';
import 'package:app_e_commerce/models/response/post.dart';

abstract class ProductRepository {
  Future<List<Category>> getCategories({
    int limit = 10,
    int page = 0,
    String status = "ACT",
  });

  Future<List<Post>> getPosts({
    int limit = 10,
    int page = 0,
    String status = "ACT",
    int categoryId = 0,
    String name = "",
    int userId = 0,
  });

  Future<Post?> getPostById(int id);

  Future<Category?> getCategoryById(int id);

  // Create operations
  Future<Category?> createCategory({
    required String name,
    String? imageUrl,
    String status = "ACT",
  });

  Future<Post?> createPost({
    required String title,
    required String description,
    required int categoryId,
    String? image,
    String status = "ACT",
  });

  Future<String?> uploadImage(File imageFile);
}
