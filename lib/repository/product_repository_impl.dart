import 'dart:convert';
import 'dart:io';

import 'package:app_e_commerce/data/local/user_data_local_storage.dart';
import 'package:app_e_commerce/models/Request/CategoryListRequest.dart';
import 'package:app_e_commerce/models/Request/PostListRequest.dart';
import 'package:app_e_commerce/models/response/category.dart';
import 'package:app_e_commerce/models/response/post.dart';
import 'package:app_e_commerce/repository/product_repository.dart';
import 'package:app_e_commerce/service/constant_uri.dart';
import 'package:app_e_commerce/service/remote_service_impl.dart';
import 'package:http/http.dart' as http;

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
    int userId = 0,
  }) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      var response = await serviceApi.postApi(
        uri: ConstantUri.postListPath,
        body: jsonEncode(PostListRequest(
          limit: limit,
          page: page,
          userId: userId,
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

      // Use list endpoint with ID filter instead of /{id} endpoint
      var response = await serviceApi.postApi(
        uri: ConstantUri.postListPath,
        body: jsonEncode({
          "limit": 1,
          "page": 0,
          "userId": 0,
          "status": "ACT",
          "id": id,
          "categoryId": 0,
          "name": "",
        }),
        token: token,
      );

      if (response.isSuccess == true && response.data != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response.data);

        if (jsonData['data'] != null) {
          // API returns array, get first item
          final List<dynamic> postsJson = jsonData['data'] is List
              ? jsonData['data']
              : [];

          if (postsJson.isNotEmpty) {
            return Post.fromJson(postsJson.first);
          }
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

  @override
  Future<Category?> createCategory({
    required String name,
    String? imageUrl,
    String status = "ACT",
  }) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      var response = await serviceApi.postApi(
        uri: ConstantUri.categoryCreatePath,
        body: jsonEncode({
          "id": 0,
          "name": name,
          "imageUrl": imageUrl,
          "status": status,
          "createAt": "",
          "createBy": "",
          "updateAt": null,
          "updateBy": null,
        }),
        token: token,
      );

      if (response.isSuccess == true && response.data != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response.data);

        // API returns success message string, not the created category object
        // Return a placeholder category to indicate success
        if (jsonData['code'] == 'SUC-000' || jsonData['message'] != null) {
          return Category(
            id: 0,
            name: name,
            imageUrl: imageUrl,
            status: status,
          );
        }
      }
      return null;
    } catch (e) {
      print('Error creating category: $e');
      return null;
    }
  }

  @override
  Future<Post?> createPost({
    required String title,
    required String description,
    required int categoryId,
    String? image,
    String status = "ACT",
  }) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      var response = await serviceApi.postApi(
        uri: ConstantUri.postCreatePath,
        body: jsonEncode({
          "id": 0,
          "title": title,
          "description": description,
          "image": image,
          "totalView": 0,
          "status": status,
          "createAt": "",
          "createBy": "",
          "updateAt": null,
          "updateBy": null,
          "category": {
            "id": categoryId,
          },
          "user": {
            "id": 0, // Backend should use authenticated user
          }
        }),
        token: token,
      );

      if (response.isSuccess == true && response.data != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response.data);

        // API returns success message string, not the created post object
        // Return a placeholder post to indicate success
        if (jsonData['code'] == 'SUC-000' || jsonData['message'] != null) {
          return Post(
            id: 0,
            title: title,
            description: description,
            image: image,
            totalView: 0,
            status: status,
          );
        }
      }
      return null;
    } catch (e) {
      print('Error creating post: $e');
      return null;
    }
  }

  @override
  Future<String?> uploadImage(File imageFile) async {
    try {
      // Get auth token
      String? token = await userDataStorage.getAccessToken();

      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ConstantUri.imageUploadPath),
      );

      // Add authorization header
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Add file to request
      request.files.add(
        await http.MultipartFile.fromPath('File', imageFile.path),
      );

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Extract filename from response: response.data.data
        if (jsonData['data'] != null && jsonData['data']['data'] != null) {
          return jsonData['data']['data'] as String;
        }
      }
      return null;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
