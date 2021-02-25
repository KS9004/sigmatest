// To parse this JSON data, do
//
//     final sigmT = sigmTFromJson(jsonString);

import 'dart:convert';


class SigmaModel {
  SigmaModel({
    this.id,
    this.title,
    this.displayName,
    this.meta,
    this.description,
    this.v,
  });


  String id;
  String title;
  String displayName;
  String meta;
  String description;
  int v;

  factory SigmaModel.fromJson(Map<String, dynamic> json) => SigmaModel(
    id: json["_id"],
    title: json["title"],
    displayName: json["displayName"],
    meta: json["meta"] == null ? null : json["meta"],
    description: json["description"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "displayName": displayName,
    "meta": meta == null ? null : meta,
    "description": description,
    "__v": v,
  };

  Map<String, dynamic> toMap() => {
    "_id": id,
    "title": title,
    "displayName": displayName,
    "meta": meta == null ? null : meta,
    "description": description,
    "__v": v,
  };
}
