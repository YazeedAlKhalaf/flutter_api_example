import 'package:meta/meta.dart';

class Name {
  final String title;
  final String first;
  final String last;

  const Name({
    @required this.title,
    @required this.first,
    @required this.last,
  });

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      title: map["title"],
      first: map["first"],
      last: map["last"],
    );
  }
}
