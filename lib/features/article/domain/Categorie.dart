// To parse this JSON data, do
//
//     final categorie = categorieFromMap(jsonString);

import 'dart:convert';

Categorie categorieFromMap(String str) => Categorie.fromMap(json.decode(str));

String categorieToMap(Categorie data) => json.encode(data.toMap());

class Categorie {
  String? id;
  String? nom;

  Categorie({
    this.id,
    this.nom,
  });

  factory Categorie.fromMap(Map<String, dynamic> json) => Categorie(
    id: json["id"],
    nom: json["nom"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nom": nom,
  };
}
