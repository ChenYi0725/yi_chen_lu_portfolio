import 'package:flutter/material.dart';

class PhotoExpansionController extends ChangeNotifier {
  int? _expandedIndex;
  int? _expandedRow;

  int? get expandedIndex => _expandedIndex;
  int? get expandedRow => _expandedRow;

  void toggle({required int index, required int row}) {
    //同一個
    if (_expandedIndex == index) {
      _expandedIndex = null;
      _expandedRow = null;
      notifyListeners();
      return;
    }

    //不同行
    if (_expandedRow != null && _expandedRow != row) {
      _expandedIndex = index;
      _expandedRow = row;
      notifyListeners();
      return;
    }

    //同行不同項
    if (_expandedIndex != null) {
      _expandedIndex = null;
      _expandedRow = null;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 400), () {
        _expandedIndex = index;
        _expandedRow = row;
        notifyListeners();
      });
      return;
    }

    //沒東西展開
    _expandedIndex = index;
    _expandedRow = row;
    notifyListeners();
  }

  void clear() {
    _expandedIndex = null;
    _expandedRow = null;
    notifyListeners();
  }
}
