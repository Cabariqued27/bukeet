import 'dart:convert';

class Field {
  int? id;
  int? players;
  List<dynamic>? images;
  int? order;
  int? arenaId;

  Field({
    this.id,
    this.players,
    this.images,
    this.order,
    this.arenaId,
  });

  factory Field.fromRawJson(String str) => Field.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        players: json["players"],
        images: json["images"],
        order: json["order"],
        arenaId: json["arenaId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "players": players,
        "images": images,
        "order": order,
        "arenaId": arenaId,
      };
}
