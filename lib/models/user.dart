// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.address,
    required this.id,
    required this.userId,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
  });

  final Address address;
  final String id;
  final int userId;
  final String email;
  final String username;
  final String password;
  final String phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
    address: Address.fromJson(json["address"]),
    id: json["_id"],
    userId: json["id"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": address.toJson(),
    "_id": id,
    "id": userId,
    "email": email,
    "username": username,
    "password": password,
    "phone": phone,
  };
}

class Address {
  Address({
    required this.geolocation,
    required this.city,
    required this.street,
  });

  final Geolocation geolocation;
  final String city;
  final String street;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    geolocation: Geolocation.fromJson(json["geolocation"]),
    city: json["city"],
    street: json["street"],
  );

  Map<String, dynamic> toJson() => {
    "geolocation": geolocation.toJson(),
    "city": city,
    "street": street,
  };
}

class Geolocation {
  Geolocation({
    required this.lat,
    required this.long,
  });

  final String lat;
  final String long;

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
  };
}
