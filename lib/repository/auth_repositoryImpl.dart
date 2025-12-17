import 'dart:convert';

import 'package:app_e_commerce/models/Request/Login_request.dart';
import 'package:app_e_commerce/models/Request/Register_request.dart';
import 'package:app_e_commerce/models/api_base_response.dart';
import 'package:app_e_commerce/models/response/Login_response.dart';
import 'package:app_e_commerce/repository/auth_repository.dart';
import 'package:app_e_commerce/service/constant_uri.dart';
import 'package:app_e_commerce/service/remote_service_impl.dart';

class AuthRepositoryImpl implements AuthRepository{
  final serviceApi = RemoteServiceImpl();
  @override
  Future<LoginResponse> login (String username, String password) async{
    LoginResponse loginResponse = new LoginResponse();
    var response = await serviceApi.postApi(uri: ConstantUri.loginPath,
        body: jsonEncode(LoginRequest(phoneNumber: username,password: password).toJson()));

    if(response.isSuccess == true){
      return LoginResponse.fromJson(jsonDecode(response.data));
    }
    return loginResponse;
  }

  @override
  Future<ApiBaseResponse> register(String username, String firstName, String lastName, String email, String phoneNumber, String password) async {
    var response = await serviceApi.postApi(
      uri: ConstantUri.registerPath,
      body: jsonEncode(RegisterRequest(
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: password,
        profile: "NON",
        role: "USER",
      ).toJson())
    );

    return response;
  }

  @override
  Future<LoginResponse?> refreshToken(String refreshToken) async {
    try {
      var response = await serviceApi.postApi(
        uri: ConstantUri.refreshTokenPath,
        body: jsonEncode({"refreshToken": refreshToken}),
      );

      if (response.isSuccess == true && response.data != null) {
        return LoginResponse.fromJson(jsonDecode(response.data));
      }
      return null;
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }
}