import 'package:get_storage/get_storage.dart';

class UserDataLocalStorage {
  static const String _keyUsername = "username";
  static const String _keyEmail = "email";
  static const String _keyPhone = "phone";
  static const String _keyAccessToken = "accessToken";
  static const String _keyRefreshToken = "refreshToken";
  static const String _keyUserId = "userId";

  final storage = GetStorage();

  // Save user information after login
  Future<void> saveUserInformation({
    String? username,
    String? email,
    String? phone,
    String? accessToken,
    String? refreshToken,
    int? userId,
  }) async {
    if (username != null) await storage.write(_keyUsername, username);
    if (email != null) await storage.write(_keyEmail, email);
    if (phone != null) await storage.write(_keyPhone, phone);
    if (accessToken != null) await storage.write(_keyAccessToken, accessToken);
    if (refreshToken != null) await storage.write(_keyRefreshToken, refreshToken);
    if (userId != null) await storage.write(_keyUserId, userId);
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return storage.read(_keyAccessToken);
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return storage.read(_keyRefreshToken);
  }

  // Get username
  Future<String?> getUsername() async {
    return storage.read(_keyUsername);
  }

  // Get email
  Future<String?> getEmail() async {
    return storage.read(_keyEmail);
  }

  // Get phone
  Future<String?> getPhone() async {
    return storage.read(_keyPhone);
  }

  // Get user ID
  Future<int?> getUserId() async {
    return storage.read(_keyUserId);
  }

  // Clear all user data (logout)
  Future<void> clearUserData() async {
    await storage.erase();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    String? token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}