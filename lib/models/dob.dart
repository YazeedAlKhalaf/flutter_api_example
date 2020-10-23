import 'package:meta/meta.dart';

class DOB {
  final String date;
  final int age;

  const DOB({
    @required this.date,
    @required this.age,
  });

  factory DOB.fromMap(Map<String, dynamic> map) {
    return DOB(
      date: map["date"],
      age: map["age"],
    );
  }
}
