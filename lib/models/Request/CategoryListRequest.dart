class CategoryListRequest {
  CategoryListRequest({
    this.limit,
    this.page,
    this.userId,
    this.status,
    this.id,
  });

  CategoryListRequest.fromJson(dynamic json) {
    limit = json['limit'];
    page = json['page'];
    userId = json['userId'];
    status = json['status'];
    id = json['id'];
  }

  int? limit;
  int? page;
  int? userId;
  String? status;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['limit'] = limit;
    map['page'] = page;
    map['userId'] = userId;
    map['status'] = status;
    map['id'] = id;
    return map;
  }
}
