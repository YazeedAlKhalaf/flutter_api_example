import 'dart:async';

import 'package:api_usage/models/random_user_response.dart';
import 'package:api_usage/screens/details_screen.dart';
import 'package:api_usage/screens/url_shortener_secreen.dart';
import 'package:api_usage/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:api_usage/models/random_user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<RandomUser> _randomUsersList = <RandomUser>[];
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        await getRandomUsers(
          goToNextPage: true,
        );
      }
    });

    super.initState();
  }

  Future getRandomUsers({
    bool goToNextPage = false,
    bool refresh = false,
  }) async {
    var result = await _apiService.getRandomUsers(
      goToNextPage: goToNextPage,
      refresh: refresh,
    );
    if (result is RandomUserResponse) {
      setState(() {
        if (refresh) {
          _randomUsersList = [];
        }
        _randomUsersList.addAll(result.randomUsersList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Random Users',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cut,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => UrlShortenerScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getRandomUsers(
            refresh: true,
          );
        },
        child: FutureBuilder(
          future: getRandomUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: _randomUsersList.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                RandomUser randomUser = _randomUsersList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      randomUser.picture.thumbnail,
                    ),
                  ),
                  title: Text(
                    '${randomUser.name.first} ${randomUser.name.last}',
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Phone: " + randomUser.phone,
                      ),
                      Text(
                        "Birth Date: " +
                            DateFormat('dd.MM.yyyy').format(
                              DateTime.parse(
                                randomUser.dob.date,
                              ),
                            ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    "${index + 1}",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => DetailsScreen(
                          randomUser: randomUser,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go To Top',
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: Duration(
              milliseconds: _randomUsersList.length ?? 0 / 50,
            ),
            curve: Curves.easeInOut,
          );
        },
        child: Icon(
          Icons.arrow_upward,
        ),
      ),
    );
  }
}
