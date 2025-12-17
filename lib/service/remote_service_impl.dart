import 'dart:convert';
import 'package:app_e_commerce/data/local/user_data_local_storage.dart';
import 'package:app_e_commerce/models/api_base_response.dart';
import 'package:app_e_commerce/models/response/Login_response.dart';
import 'package:app_e_commerce/service/constant_uri.dart';
import 'package:app_e_commerce/service/remote_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as httpClient;

class RemoteServiceImpl extends RemoteService{
  final userDataStorage = UserDataLocalStorage();

  // Pretty print JSON for better readability
  String _prettyJson(dynamic json) {
    try {
      var spaces = ' ' * 2;
      var encoder = JsonEncoder.withIndent(spaces);
      return encoder.convert(jsonDecode(json));
    } catch (e) {
      return json.toString();
    }
  }


  @override
  Future<ApiBaseResponse> postApi({required String uri, required body, String? token}) async {
    var responseBody = new ApiBaseResponse();

    if(kDebugMode){
      print("📤 API Request:");
      print("   URL: $uri");
      print("   Body:");
      print(_prettyJson(body));
    }

    try {
      // Build headers with optional Authorization token
      Map<String, String> headers = {"Content-Type": "application/json"};
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }

      var response = await httpClient.post(
        Uri.parse(uri),
        body: body,
        headers: headers,
      ).timeout(Duration(
        seconds: 120
      ));

      if(kDebugMode){
        print("✅ API Response [${response.statusCode}]:");
        print(_prettyJson(response.body));
      }

      if(response.statusCode == 200 || response.statusCode == 201){
        responseBody.isSuccess = true;
        responseBody.errorCode = "${response.statusCode}";
        responseBody.message = "Success";
        responseBody.data = response.body;
      }else if(response.statusCode == 401){
        // Token expired - try to refresh (but not if this IS the refresh endpoint to avoid infinite loop)
        if(!uri.contains(ConstantUri.refreshTokenPath)){
          if(kDebugMode){
            print("🔄 Token expired, attempting refresh...");
          }

          String? refreshToken = await userDataStorage.getRefreshToken();
          if(refreshToken != null){
            // Call refresh endpoint directly (avoid circular dependency)
            var refreshResponse = await httpClient.post(
              Uri.parse(ConstantUri.refreshTokenPath),
              body: jsonEncode({"refreshToken": refreshToken}),
              headers: {"Content-Type": "application/json"},
            ).timeout(Duration(seconds: 120));

            if(refreshResponse.statusCode == 200){
              try {
                var newTokenResponse = LoginResponse.fromJson(jsonDecode(refreshResponse.body));

                if(newTokenResponse.accessToken != null){
                  // Save new tokens
                  await userDataStorage.saveUserInformation(
                    accessToken: newTokenResponse.accessToken,
                    refreshToken: newTokenResponse.refreshToken,
                  );

                  if(kDebugMode){
                    print("✅ Token refreshed successfully, retrying request...");
                  }

                  // Retry original request with new token
                  return await postApi(uri: uri, body: body, token: newTokenResponse.accessToken);
                }
              } catch (e) {
                if(kDebugMode){
                  print("❌ Error parsing refresh token response: $e");
                }
              }
            }
          }

          // Refresh failed
          if(kDebugMode){
            print("❌ Token refresh failed - user needs to login again");
          }
        }

        responseBody.isSuccess = false;
        responseBody.errorCode = "401";
        responseBody.message = "Session expired. Please login again.";
        responseBody.data = response.body;
      }else{
        responseBody.isSuccess = false;
        responseBody.errorCode = "${response.statusCode}";
        responseBody.message = "Error";
        responseBody.data = response.body;
        if(kDebugMode){
          print("❌ Error Response [${response.statusCode}]:");
          print(_prettyJson(response.body));
        }
      }
    } catch (e) {
      print("Network Error: $e");
      responseBody.isSuccess = false;
      responseBody.errorCode = "NETWORK_ERROR";
      responseBody.message = "Network error. Please check your connection.";
    }

    return responseBody;
  }
  
}