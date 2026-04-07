class CreateAccountModel {
  final String status;
  final String message;
  final RegisterUser? user;

  CreateAccountModel({
    required this.status,
    required this.message,
    this.user,
  });

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) {
    return CreateAccountModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      user: json["data"] != null
          ? RegisterUser.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": user?.toJson(),
    };
  }
}

class RegisterUser {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  RegisterUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
      id: json["id"]?.toString(),
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
    };
  }
}