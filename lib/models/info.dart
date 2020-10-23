import 'package:meta/meta.dart';

class Info {
  final String seed;
  final int results;
  final int page;
  final String version;

  const Info({
    @required this.seed,
    @required this.results,
    @required this.page,
    @required this.version,
  });

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      seed: map['seed'],
      results: map['results'],
      page: map['page'],
      version: map['version'],
    );
  }
}
