import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    this.id,
    this.username,
    this.email,
    this.password,
    this.plate,
  });

  String id;
  String username;
  String email;
  String password;
  String plate;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        plate: json["plate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "plate": plate,
      };
}
