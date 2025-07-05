import 'dart:async';
import 'package:flutter/material.dart';

class CarouselProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final List<String> images;
  Timer? _timer;

  CarouselProvider(this.images) {
    _startAutoSlide();
  }

  int get currentIndex => _currentIndex;
  String get currentImage => images[_currentIndex];

  void goToNext() {
    _currentIndex = (_currentIndex + 1) % images.length;
    _resetTimer();
    notifyListeners();
  }

  void goToPrevious() {
    _currentIndex = (_currentIndex - 1 + images.length) % images.length;
    _resetTimer();
    notifyListeners();
  }

  void goToIndex(int index) {
    _currentIndex = index;
    _resetTimer();
    notifyListeners();
  }

  void _resetTimer() {
    _timer?.cancel();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      goToNext();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
