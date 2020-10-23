import 'package:api_usage/models/random_user.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final RandomUser randomUser;

  const DetailsScreen({
    Key key,
    @required this.randomUser,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(
          randomUser.picture.large,
        ),
      ),
    );
  }
}
