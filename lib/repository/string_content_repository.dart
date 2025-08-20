import 'package:flutter/material.dart';
import '../controller/string_content_service.dart';

class StringContentRepository extends ChangeNotifier {
  final StringContentService service = StringContentService();
  Map<String, List<String>> pageContents = {};

  bool loaded = false;

  Future<void> loadAll(String sheetUrl) async {
    pageContents = await service.fetchAllPages(sheetUrl);
    loaded = true;
    notifyListeners();
  }

  List<String> getPageContent(String page) {
    return pageContents[page] ?? [];
  }
}
