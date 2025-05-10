import 'dart:convert';

class User {
  int? id;
  String? userUId;
  String email;
  String firstName;
  String? lastName;
  String? userType;
  String phoneType;
  String? imageUrl;
  String? registerAt;
  String? phoneNumber;
  String? state;
  String? country;
  DateTime? birthDate;
  String? gender;
  bool? validatedEmail;
  bool? hasPassword;
  String? fcmToken;
  

  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.phoneType,
    this.userUId,
    this.lastName,
    this.userType,
    this.imageUrl,
    this.registerAt,
    this.phoneNumber,
    this.state,
    this.country,
    this.birthDate,
    this.gender,
    this.validatedEmail,
    this.hasPassword,
    this.fcmToken,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userUId: json["userUId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userType: json["userType"],
        imageUrl: json["imageUrl"],
        registerAt: json["registerAt"],
        phoneType: json["phoneType"],
        phoneNumber: json["phoneNumber"],
        state: json["state"],
        country: json["country"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        gender: json["gender"],
        validatedEmail: json["validatedEmail"],
        hasPassword: json["hasPassword"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userUId": userUId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "userType": userType,
        "imageUrl": imageUrl,
        "registerAt": registerAt,
        "phoneType": phoneType,
        "phoneNumber": phoneNumber,
        "state": state,
        "country": country,
        "birthDate": birthDate?.toIso8601String(),
        "gender": gender,
        "validatedEmail": validatedEmail,
        "hasPassword": hasPassword,
        "fcmToken": fcmToken,
      };
}

class UpdateUser {
  String email;
  String? firstName;
  String? lastName;
  String? gender;
  DateTime? birthDate;
  String? imageUrl;

  UpdateUser({
    required this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthDate,
    this.imageUrl,
  });
}
