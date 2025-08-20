import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class StringContentService {
  StringContentService();

  Future<Map<String, List<String>>> fetchAllPages(String sheetUrl) async {
    try {
      final uri = Uri.parse(sheetUrl);
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception("Failed to load sheet data: ${response.statusCode}");
      }

      final csvString = utf8.decode(response.bodyBytes);
      final rows = const CsvToListConverter().convert(csvString);

      if (rows.isEmpty) return {};

      final headers = rows.first.map((e) => e.toString()).toList();
      final pageIndex = headers.indexOf("page");
      final contentIndex = headers.indexOf("content");
      if (pageIndex == -1 || contentIndex == -1) {
        throw Exception("Missing 'page' or 'content' column");
      }

      final Map<String, List<String>> result = {};
      for (int i = 1; i < rows.length; i++) {
        final row = rows[i].map((e) => e.toString()).toList();
        if (row.length <= contentIndex) continue;
        final page = row[pageIndex].trim();
        final content = row[contentIndex].trim();

        result.putIfAbsent(page, () => []);
        result[page]!.add(content);
      }

      return result;
    } catch (e) {
      print("Error fetching CSV: $e");
      return {};
    }
  }
}
