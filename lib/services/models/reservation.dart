import 'dart:convert';

class Reservation {
  int? id;
  String? createdAt;
  int? userId;
  int? fieldId;
  DateTime? date;
  int? timeSlot;
  DateTime? updateAt;
  int? totalPrice;
  String? reference;
  String? paymentStatus;
  String? reservationStatus;

  Reservation({
    this.id,
    this.createdAt,
    this.userId,
    this.fieldId,
    this.date,
    this.timeSlot,
    this.updateAt,
    this.totalPrice,
    this.reference,
    this.paymentStatus,
    this.reservationStatus,
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
    updateAt: json["updateAt"] == null
        ? null
        : DateTime.parse(json["updateAt"]),
    totalPrice: json["totalPrice"],
    reference: json["reference"],
    paymentStatus: json["paymentStatus"],
    reservationStatus: json["reservationStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt,
    "userId": userId,
    "fieldId": fieldId,
    "date": date?.toIso8601String(),
    "timeSlot": timeSlot,
    "updateAt": updateAt?.toIso8601String(),
    "totalPrice": totalPrice,
    "reference": reference,
    "paymentStatus": paymentStatus,
    "reservationStatus": reservationStatus,
  };
}

class UpdateReservation {
  int id;
  String? paymentStatus;
  String? reservationStatus;
 

  UpdateReservation({required this.id, this.paymentStatus,this.reservationStatus});
}
