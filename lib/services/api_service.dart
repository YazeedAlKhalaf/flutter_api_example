import 'dart:convert';

import 'package:api_usage/models/random_user_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _singleton = ApiService._internal();

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal();

  RandomUserResponse _lastResponse;

  Future getRandomUsers({
    int usersCount = 10,
    bool goToNextPage = false,
    bool refresh = false,
  }) async {
    try {
      const String _baseUrl = 'https://randomuser.me/api';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      http.Response response;

      if (goToNextPage && _lastResponse != null) {
        response = await http.get(
          '$_baseUrl/?page=${_lastResponse.info.page + 1}&results=$usersCount&seed=${_lastResponse.info.seed}',
          headers: headers,
        );
      } else {
        response = await http.get(
          '$_baseUrl/?results=$usersCount',
          headers: headers,
        );
      }

      Map<String, dynamic> responseDecoded = json.decode(response.body);

      RandomUserResponse randomUserResponse =
          RandomUserResponse.fromMap(responseDecoded);

      _lastResponse = randomUserResponse;

      if (refresh) {
        _lastResponse = null;
      }

      return randomUserResponse;
    } catch (exception) {
      print(exception);
    }
  }

  Future shortenUrl({@required String longUrl}) async {
    try {
      const String _baseUrl = 'https://cleanuri.com';
      Map<String, String> body = {
        'url': Uri.encodeFull(longUrl),
      };
      http.Response response = await http.post(
        "$_baseUrl/api/v1/shorten",
        body: body,
      );

      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse['result_url'];
    } catch (exception) {
      print(exception);
    }
  }
}
