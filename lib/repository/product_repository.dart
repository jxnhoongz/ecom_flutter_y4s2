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
  });

  Future<Post?> getPostById(int id);

  Future<Category?> getCategoryById(int id);
}
