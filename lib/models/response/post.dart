import 'category.dart';
import 'User.dart';

class Post {
  Post({
    this.createAt,
    this.createBy,
    this.updateAt,
    this.updateBy,
    this.id,
    this.title,
    this.description,
    this.image,
    this.totalView,
    this.status,
    this.category,
    this.user,
  });

  Post.fromJson(dynamic json) {
    createAt = json['createAt'];
    createBy = json['createBy'];
    updateAt = json['updateAt'];
    updateBy = json['updateBy'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    totalView = json['totalView'];
    status = json['status'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? createAt;
  String? createBy;
  dynamic updateAt;
  dynamic updateBy;
  int? id;
  String? title;
  String? description;
  String? image;
  int? totalView;
  String? status;
  Category? category;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createAt'] = createAt;
    map['createBy'] = createBy;
    map['updateAt'] = updateAt;
    map['updateBy'] = updateBy;
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['image'] = image;
    map['totalView'] = totalView;
    map['status'] = status;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
