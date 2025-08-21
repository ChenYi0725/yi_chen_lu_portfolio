import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

class CoverProvider extends ChangeNotifier {
  List<String> _photoUrls = [];
  final List<Widget> _photos = [];
  List<String> get photoUrls => _photoUrls;
  List<Widget> get photos => _photos;

  Future<void> loadPhotos(String csvUrl, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(csvUrl));
      if (response.statusCode == 200) {
        final csvBody = response.body;
        final rows = const CsvToListConverter().convert(csvBody);

        _photoUrls = rows.map((row) => row[0].toString()).toList();
        _photos.clear();

        for (var url in _photoUrls) {
          final image = Image.network(url, fit: BoxFit.cover);
          precacheImage(image.image, context);
          _photos.add(image);
        }

        notifyListeners();
      } else {
        debugPrint('Failed to load CSV: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching CSV: $e');
    }
  }
}
