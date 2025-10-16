import 'dart:convert';

class Arena {
  int? id;
  int? ownerId;
  String? name;
  String? address;
  String? city;
  bool? isVerified;
  String? imageUrl;
  int? order;

  Arena({
    this.id,
    this.ownerId,
    this.name,
    this.address,
    this.city,
    this.isVerified,
    this.imageUrl,
    this.order,
  });

  factory Arena.fromRawJson(String str) => Arena.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Arena.fromJson(Map<String, dynamic> json) => Arena(
    id: json["id"],
    ownerId: json["ownerId"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    isVerified: json["isVerified"],
    imageUrl: json["imageUrl"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "name": name,
    "address": address,
    "city": city,
    "isVerified": isVerified,
    "imageUrl": imageUrl,
    "order": order,
  };
}
