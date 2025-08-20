import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:csv/csv.dart';

class CoverProvider extends ChangeNotifier {
  List<String> _photoUrls = [];
  int _currentIndex = 0;
  Timer? _timer;

  List<String> get photoUrls => _photoUrls;
  int get currentIndex => _currentIndex;

  Future<void> fetchPhotos(String sheetUrl) async {
    try {
      final response = await http.get(Uri.parse(sheetUrl));
      if (response.statusCode == 200) {
        List<List<dynamic>> csvTable = const CsvToListConverter().convert(
          response.body,
        );
        _photoUrls = csvTable.map((row) => row[0].toString()).toList();
        _currentIndex = 0;
        // 確保只啟動一次
        _startAutoFade();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('CoverProvider fetchPhotos error: $e');
    }
  }

  void _startAutoFade() {
    _timer?.cancel();
    if (_photoUrls.isEmpty) return;

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _currentIndex = (_currentIndex + 1) % _photoUrls.length;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
