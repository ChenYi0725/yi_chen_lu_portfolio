import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../model/photo_model.dart';

class GalleryProvider extends ChangeNotifier {
  List<Photo> photos = [];
  bool get loaded => photos.isNotEmpty;
  String url;
  GalleryProvider({required this.url});
  Future<void> fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final rows = const CsvToListConverter().convert(decoded);
        final dataRows = rows.skip(1).toList();

        photos = dataRows.map((row) {
          final data = row.toList();
          return Photo(
            coverImagePath: "",
            title: data[0].toString(),
            description: data[1].toString(),
            contentImages: [],

            // programName: data[0].toString(),
            // directorsName: data[1]
            //     .toString()
            //     .split(";")
            //     .map((e) => e.trim())
            //     .toList(),
            // performanceVenues: data[2].toString(),
            // performanceLocation: data[3].toString(),
            // programLink: data[4].toString(),
          );
        }).toList();

        notifyListeners();
      } else {
        debugPrint('Failed to load CSV: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching CSV: $e');
    }
  }
}

// return Photo(
// programName: data[0].toString(),
// directorsName: data[1]
//     .toString()
//     .split(";")
//     .map((e) => e.trim())
//     .toList(),
// performanceVenues: data[2].toString(),
// performanceLocation: data[3].toString(),
// programLink: data[4].toString(),
// isOutsideUrl: data[5].toString().toLowerCase() == 'true',
// );
