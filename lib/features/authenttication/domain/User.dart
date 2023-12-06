// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  String? id;
  String? nom;
  String? email;
  String? genre;
  String? phone;
  String? password;

  User({
    this.id,
    this.nom,
    this.email,
    this.genre,
    this.phone,
    this.password,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    nom: json["nom"],
    email: json["email"],
    genre: json["genre"],
    phone: json["phone"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nom": nom,
    "email": email,
    "genre": genre,
    "phone": phone,
    "password": password,
  };
}
