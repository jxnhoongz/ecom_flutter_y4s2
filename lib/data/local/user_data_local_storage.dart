class UserDataLocalStorage {
  static String username = "uername";
  static String email = "email";
  static String phone = "phone";
  static String accessToken = "accessToken";
  static String refreshToken = "refreshToken";

  static saveUserInformation({User? user,String? accessToken,String? refreshToken}){
    var storage = GetStorage();
  };

}