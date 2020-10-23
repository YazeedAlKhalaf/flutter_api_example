import 'package:meta/meta.dart';
import 'package:api_usage/models/dob.dart';
import 'package:api_usage/models/name.dart';
import 'package:api_usage/models/picture.dart';

class RandomUser {
  final String gender;
  final Name name;
  final String email;
  final DOB dob;
  final String phone;
  final Picture picture;
  final String nat;

  const RandomUser({
    @required this.gender,
    @required this.name,
    @required this.email,
    @required this.dob,
    @required this.phone,
    @required this.picture,
    @required this.nat,
  });

  factory RandomUser.fromMap(Map<String, dynamic> map) {
    return RandomUser(
      gender: map["gender"],
      name: Name.fromMap(map["name"]),
      email: map["email"],
      dob: DOB.fromMap(map["dob"]),
      phone: map["phone"],
      picture: Picture.fromMap(map["picture"]),
      nat: map["nat"],
    );
  }
}
