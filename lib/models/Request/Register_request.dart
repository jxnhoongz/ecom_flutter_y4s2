class RegisterRequest {
  RegisterRequest({
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.password,
      this.confirmPassword,
      this.profile,
      this.role,});

  RegisterRequest.fromJson(dynamic json) {
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    profile = json['profile'];
    role = json['role'];
  }
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;
  String? profile;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['username'] = username;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    map['profile'] = profile;
    map['role'] = role;
    return map;
  }

}
