class ApiBaseResponse {
  bool? isSuccess;
  String? message;
  String? errorCode;
  dynamic data;

  ApiBaseResponse({this.data,this.isSuccess, this.message, this.errorCode});
}
