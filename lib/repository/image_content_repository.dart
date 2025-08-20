import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageContentRepository extends ChangeNotifier {
  final Map<String, String> _images = {};

  bool _loaded = false;
  bool get loaded => _loaded;

  Future<void> loadFromGoogleSheet() async {
    final url =
        'https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID/gviz/tq?tqx=out:json&sheet=Images';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final raw = response.body;
      final jsonString = raw.substring(
        raw.indexOf('{'),
        raw.lastIndexOf('}') + 1,
      );
      final data = json.decode(jsonString);

      final rows = data['table']['rows'] as List;
      for (var row in rows) {
        final key = row['c'][0]['v'];
        final value = row['c'][1]['v'];
        _images[key] = value;
      }

      _loaded = true;
      notifyListeners();
    }
  }

  String getImage(String key) => _images[key] ?? '';
}
