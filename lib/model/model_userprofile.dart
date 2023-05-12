// To parse this JSON data, do
//
//     final modelUserProfile = modelUserProfileFromJson(jsonString);

import 'dart:convert';

ModelUserProfile modelUserProfileFromJson(String str) => ModelUserProfile.fromJson(json.decode(str));

String modelUserProfileToJson(ModelUserProfile data) => json.encode(data.toJson());

class ModelUserProfile {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelUserProfile({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelUserProfile.fromJson(Map<String, dynamic> json) => ModelUserProfile(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String username;
  String email;
  String password;
  String fullname;
  DateTime tglDaftar;

  Datum({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.fullname,
    required this.tglDaftar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    fullname: json["fullname"],
    tglDaftar: DateTime.parse(json["tgl_daftar"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
    "fullname": fullname,
    "tgl_daftar": tglDaftar.toIso8601String(),
  };
}
