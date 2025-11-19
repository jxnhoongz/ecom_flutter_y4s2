import 'package:app_e_commerce/models/api_base_response.dart';

abstract class RemoteService{
  Future<ApiBaseResponse> postApi ({required String uri, required dynamic body});
}