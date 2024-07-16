import 'dart:convert';

class RegisterResponseModel {
  bool? error;
  String? message;

  RegisterResponseModel({
    this.error,
    this.message,
  });

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
      };
  @override
  String toString() {
    return 'RegisterResponseModel(error: $message, message: $message)';
  }
}


// class RegisterResponseModel {
//   String? email;
//   String? password;
//   String? name;
//   String? avatar;
//   String? role;
//   int? id;
//   DateTime? creationAt;
//   DateTime? updatedAt;

//   RegisterResponseModel({
//     this.email,
//     this.password,
//     this.name,
//     this.avatar,
//     this.role,
//     this.id,
//     this.creationAt,
//     this.updatedAt,
//   });

//   factory RegisterResponseModel.fromJson(String str) =>
//       RegisterResponseModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
//       RegisterResponseModel(
//         email: json["email"],
//         password: json["password"],
//         name: json["name"],
//         avatar: json["avatar"],
//         role: json["role"],
//         id: json["id"],
//         creationAt: json["creationAt"] == null
//             ? null
//             : DateTime.parse(json["creationAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "email": email,
//         "password": password,
//         "name": name,
//         "avatar": avatar,
//         "role": role,
//         "id": id,
//         "creationAt": creationAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };

//   @override
//   String toString() {
//     return 'RegisterResponseModel(email: $email, password: $password, name: $name, avatar: $avatar, role: $role, id: $id, creationAt: $creationAt, updatedAt: $updatedAt)';
//   }
// }

// class RegisterResponseModel {
//   String? email;
//   int? id;
//   String? name;

//   RegisterResponseModel({
//     this.email,
//     this.id,
//     this.name,
//   });

//   factory RegisterResponseModel.fromJson(String str) =>
//       RegisterResponseModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toJson());

//   factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
//       RegisterResponseModel(
//         email: json["email"],
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toMap() => {
//         "email": email,
//         "id": id,
//         "name": name,
//       };

//   @override
//   String toString() {
//     return 'RegisterResponseModel(email: $email, id: $id, name: $name)';
//   }
// }