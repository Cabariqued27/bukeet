import 'dart:convert';

class Reservation {
  int? id;
  String? createdAt;
  int? userId;
  int? fieldId;
  DateTime? date;
  String? timeSlot;
  DateTime? updateAt;
  bool? status;
  int? totalPrice;

  Reservation({
    this.id,
    this.createdAt,
    this.userId,
    this.fieldId,
    this.date,
    this.timeSlot,
    this.updateAt,
    this.status,
    this.totalPrice,
  });

  factory Reservation.fromRawJson(String str) =>
      Reservation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        createdAt: json["createdAt"],
        userId: json["userId"],
        fieldId: json["fieldId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeSlot: json["timeSlot"],
        updateAt:
            json["updateAt"] == null ? null : DateTime.parse(json["updateAt"]),
        status: json["status"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "userId": userId,
        "fieldId": fieldId,
        "date": date?.toIso8601String(),
        "timeSlot": timeSlot,
        "updateAt": updateAt?.toIso8601String(),
        "status": status,
        "totalPrice": totalPrice,
      };
}

class UpdateReservation {
  int id;
  bool? status;

  UpdateReservation({
    required this.id,
    this.status,
  });
}
