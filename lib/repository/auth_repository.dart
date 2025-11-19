import 'package:app_e_commerce/models/response/Login_response.dart';

abstract class AuthRepository{
  Future<LoginResponse> login (String username, String password);
}