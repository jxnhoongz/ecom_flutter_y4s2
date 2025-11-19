import 'package:app_e_commerce/models/response/Login_response.dart';

abstract class AuthRepository{
  Future<LoginResponse> login (String username, String password);
  Future<LoginResponse> register (String username, String firstName, String lastName, String email, String phoneNumber, String password);
}