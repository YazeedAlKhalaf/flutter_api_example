import 'package:api_usage/services/api_service.dart';
import 'package:flutter/material.dart';

class UrlShortenerScreen extends StatefulWidget {
  @override
  _UrlShortenerScreenState createState() => _UrlShortenerScreenState();
}

class _UrlShortenerScreenState extends State<UrlShortenerScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _urlController = TextEditingController();

  String _shortenedUrl = '';
  void setShortenedUrl(String newValue) {
    setState(() {
      _shortenedUrl = newValue;
    });
  }

  bool _isBusy = false;
  void setBusy(bool newValue) {
    setState(() {
      _isBusy = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'URL Shortner',
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Short URL: $_shortenedUrl",
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'URL',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: _urlController.text.contains('http') &&
                                _urlController.text.contains('.') &&
                                _urlController.text.contains('://') &&
                                _urlController.text.length >= 10
                            ? () async {
                                setBusy(true);
                                var result = await _apiService.shortenUrl(
                                  longUrl: _urlController.text,
                                );
                                _urlController.clear();

                                if (result is String) {
                                  setShortenedUrl(result);
                                }
                                setBusy(false);
                              }
                            : null,
                        child: Text(
                          'Shorten URL',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _isBusy
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(
                    0.75,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
