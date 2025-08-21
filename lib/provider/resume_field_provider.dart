import 'package:flutter/foundation.dart';

class ResumeFieldProvider with ChangeNotifier {
  bool _isHovering = false;
  bool get isHovering => _isHovering;

  void setHover(bool hover) {
    if (_isHovering != hover) {
      _isHovering = hover;
      notifyListeners();
    }
  }
}
