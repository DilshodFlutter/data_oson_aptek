// To parse this JSON data, do
//
//     final osonAptekaMessageModel = osonAptekaMessageModelFromJson(jsonString);

import 'dart:convert';

List<OsonAptekMessageModel> osonAptekaMessageModelFromJson(String str) =>
    List<OsonAptekMessageModel>.from(
        json.decode(str).map((x) => OsonAptekMessageModel.fromJson(x)));

// String osonAptekaMessageModelToJson(List<OsonAptekaMessageModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OsonAptekMessageModel {
  OsonAptekMessageModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory OsonAptekMessageModel.fromJson(Map<String, dynamic> json) =>
      OsonAptekMessageModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
