import 'package:app_e_commerce/models/api_base_response.dart';
import 'package:app_e_commerce/service/remote_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as httpClient;

class RemoteServiceImpl extends RemoteService{


  @override
  Future<ApiBaseResponse> postApi({required String uri, required body}) async {
    var responseBody = new ApiBaseResponse();
    print("Interception request uri {} $uri and body request {} : $body");
    var response = await httpClient.post(
      Uri.parse(uri),
      body: body,
      headers: {"Content-Type": "application/json"},
    ).timeout(Duration(
      seconds: 120
    ));

    print("API Response [${response.statusCode}]: ${response.body}");

    if(response.statusCode == 200 || response.statusCode == 201){
      responseBody.isSuccess = true;
      responseBody.errorCode = "${response.statusCode}";
      responseBody.message = "Success";
      responseBody.data = response.body;
      if(kDebugMode){
        print("Response Body: ${response.body}");
      }
    }else{
      responseBody.isSuccess = false;
      responseBody.errorCode = "${response.statusCode}";
      responseBody.message = "Error";
      responseBody.data = response.body;
      if(kDebugMode){
        print("Error Response [${response.statusCode}]: ${response.body}");
      }
    }

    return responseBody;
  }
  
}