import 'dart:convert';

import 'package:app_e_commerce/data/local/user_data_local_storage.dart';
import 'package:app_e_commerce/models/Request/CategoryListRequest.dart';
import 'package:app_e_commerce/models/Request/PostListRequest.dart';
import 'package:app_e_commerce/models/response/category.dart';
import 'package:app_e_commerce/models/response/post.dart';
import 'package:app_e_commerce/repository/product_repository.dart';
import 'package:app_e_commerce/service/constant_uri.dart';
import 'package:app_e_commerce/service/remote_service_impl.dart';

class ProductRepositoryImpl implements ProductRepository {
  final serviceApi = RemoteServiceImpl();
  final userDataStorage = UserDataLocalStorage();

  @override
  Future<List<Category>> getCategories({
    int limit = 10,
    int page = 0,
    String status = "ACT",
  }) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      var response = await serviceApi.postApi(
        uri: ConstantUri.categoryListPath,
        body: jsonEncode(CategoryListRequest(
          limit: limit,
          page: page,
          userId: 0,
          status: status,
          id: 0,
        ).toJson()),
        token: token,
      );

      if (response.isSuccess == true && response.data != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response.data);

        // Check if data field exists and contains list
        if (jsonData['data'] != null) {
          final List<dynamic> categoriesJson = jsonData['data'] is List
              ? jsonData['data']
              : [];

          return categoriesJson
              .map((json) => Category.fromJson(json))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting categories: $e');
      return [];
    }
  }

  @override
  Future<List<Post>> getPosts({
    int limit = 10,
    int page = 0,
    String status = "ACT",
    int categoryId = 0,
    String name = "",
  }) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      var response = await serviceApi.postApi(
        uri: ConstantUri.postListPath,
        body: jsonEncode(PostListRequest(
          limit: limit,
          page: page,
          userId: 0,
          status: status,
          id: 0,
          categoryId: categoryId,
          name: name,
        ).toJson()),
        token: token,
      );

      if (response.isSuccess == true && response.data != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response.data);

        // Check if data field exists and contains list
        if (jsonData['data'] != null) {
          final List<dynamic> postsJson = jsonData['data'] is List
              ? jsonData['data']
              : [];

          return postsJson
              .map((json) => Post.fromJson(json))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting posts: $e');
      return [];
    }
  }

  @override
  Future<Post?> getPostById(int id) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      var response = await serviceApi.postApi(
        uri: '${ConstantUri.postByIdPath}/$id',
        body: jsonEncode({
          "limit": 10,
          "page": 0,
          "userId": 0,
          "status": "ACT",
          "id": id,
        }),
        token: token,
      );

      if (response.isSuccess == true && response.data != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response.data);

        if (jsonData['data'] != null) {
          return Post.fromJson(jsonData['data']);
        }
      }
      return null;
    } catch (e) {
      print('Error getting post by id: $e');
      return null;
    }
  }

  @override
  Future<Category?> getCategoryById(int id) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      var response = await serviceApi.postApi(
        uri: '${ConstantUri.categoryByIdPath}/$id',
        body: jsonEncode({
          "limit": 10,
          "page": 0,
          "userId": 0,
          "status": "ACT",
          "id": id,
        }),
        token: token,
      );

      if (response.isSuccess == true && response.data != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response.data);

        if (jsonData['data'] != null) {
          return Category.fromJson(jsonData['data']);
        }
      }
      return null;
    } catch (e) {
      print('Error getting category by id: $e');
      return null;
    }
  }
}
