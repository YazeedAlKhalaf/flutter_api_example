import 'package:meta/meta.dart';

import 'package:api_usage/models/info.dart';
import 'package:api_usage/models/random_user.dart';

class RandomUserResponse {
  final List<RandomUser> randomUsersList;
  final Info info;

  const RandomUserResponse({
    @required this.randomUsersList,
    @required this.info,
  });
  factory RandomUserResponse.fromMap(Map<String, dynamic> map) {
    decodeRandomUsersList() {
      List<RandomUser> randomUsersList = <RandomUser>[];

      for (var randomUserMap in map["results"]) {
        randomUsersList.add(RandomUser.fromMap(randomUserMap));
      }

      return randomUsersList;
    }

    return RandomUserResponse(
      randomUsersList: decodeRandomUsersList(),
      info: Info.fromMap(map["info"]),
    );
  }
}
