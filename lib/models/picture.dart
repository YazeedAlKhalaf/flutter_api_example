import 'package:meta/meta.dart';

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  const Picture({
    @required this.large,
    @required this.medium,
    @required this.thumbnail,
  });

  factory Picture.fromMap(Map<String, dynamic> map) {
    return Picture(
      large: map["large"],
      medium: map["medium"],
      thumbnail: map["thumbnail"],
    );
  }
}
