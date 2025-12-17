import 'package:app_e_commerce/models/api_base_response.dart';
import 'package:app_e_commerce/models/response/Login_response.dart';

abstract class AuthRepository{
  Future<LoginResponse> login (String username, String password);
  Future<ApiBaseResponse> register (String username, String firstName, String lastName, String email, String phoneNumber, String password);
  Future<LoginResponse?> refreshToken (String refreshToken);
}