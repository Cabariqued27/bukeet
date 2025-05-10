import 'dart:convert';

class HourAvailability {
  int? fieldId;
  String? day;
  List<dynamic>? arrayState;
  List<dynamic>? arrayPrice;

  HourAvailability({
    this.fieldId,
    this.day,
    this.arrayState,
    this.arrayPrice,
  });

  factory HourAvailability.fromRawJson(String str) =>
      HourAvailability.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourAvailability.fromJson(Map<String, dynamic> json) =>
      HourAvailability(
        fieldId: json["fieldId"],
        day: json["day"],
        arrayState: json["arrayState"],
        arrayPrice: json["arrayPrice"],
      );

  Map<String, dynamic> toJson() => {
        "fieldId": fieldId,
        "day": day,
        "arrayState": arrayState,
        "arrayPrice": arrayPrice,
      };
}


