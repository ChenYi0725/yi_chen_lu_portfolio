import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class ContactAndAboutProvider extends ChangeNotifier {
  final String sheetCsvUrl;
  bool loaded = false;

  String aboutText = '';
  String aboutImageUrl = '';
  String contactText = '';

  ContactAndAboutProvider({required this.sheetCsvUrl});

  Future<void> loadData() async {
    try {
      final response = await http.get(Uri.parse(sheetCsvUrl));

      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final csvData = const CsvToListConverter().convert(decoded);

        for (var row in csvData) {
          if (row.isEmpty) continue;
          final pageKey = row[0]?.toString().trim() ?? '';
          final content = row.length > 1 ? row[1]?.toString().trim() ?? '' : '';

          switch (pageKey) {
            case 'about':
              aboutText = content;
              break;
            case 'about_picture':
              aboutImageUrl = content;
              break;
            case 'contact':
              contactText = content;
              break;
          }
        }

        loaded = true;
        notifyListeners();
      } else {
        debugPrint('Failed to fetch CSV: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error loading CSV: $e');
    }
  }
}
