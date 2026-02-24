import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../model/photo_model.dart';

class GalleryProvider extends ChangeNotifier {
  final String url;

  List<Photo> photos = [];
  bool isLoading = false;
  bool hasLoadedOnce = false;

  GalleryProvider({required this.url});

  Future<void> fetchPhotos({int retryCount = 0}) async {
    const int maxRetry = 3;
    const Duration retryDelay = Duration(seconds: 2);

    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      final decoded = utf8.decode(response.bodyBytes);
      final rows = const CsvToListConverter().convert(decoded);
      final dataRows = rows.skip(1).toList();

      photos = dataRows.map((row) {
        final data = row.toList();
        return Photo(
          coverImagePath: data[2].toString(),
          title: data[0].toString(),
          description: data[1].toString(),
          contentImages: data[3]
              .toString()
              .split(',')
              .map((e) => e.trim())
              .toList(),
        );
      }).toList();

      hasLoadedOnce = true;
    } catch (e) {
      if (retryCount < maxRetry) {
        debugPrint('Fetch failed, retry ${retryCount + 1}/$maxRetry');
        await Future.delayed(retryDelay);
        return fetchPhotos(retryCount: retryCount + 1);
      } else {
        debugPrint('Fetch failed after $maxRetry retries: $e');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reload() async {
    await fetchPhotos();
  }
}
