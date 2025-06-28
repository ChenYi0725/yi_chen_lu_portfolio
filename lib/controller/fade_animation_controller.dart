import 'package:flutter/cupertino.dart';

class FadeProvider with ChangeNotifier {
  bool _visible = false;

  bool get visible => _visible;

  void toggle() {
    _visible = !_visible;
    notifyListeners();
  }
}
