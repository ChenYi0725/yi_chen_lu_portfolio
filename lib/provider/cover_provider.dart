import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoverProvider extends ChangeNotifier {
  List<String> _photoUrls = [];
  bool _isLoading = true;
  String? _errorMessage;
  bool _isDisposed = false;

  static const int _maxAttempts = 4;
  static const Duration _requestTimeout = Duration(seconds: 12);

  // ⭐ 預載範圍：當前圖片的前後各 3 張
  static const int _preloadRange = 3;

  List<String> get photoUrls => _photoUrls;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get photoCount => _photoUrls.length;

  // ✅ 動態建立圖片 Widget
  Widget getPhoto(int index) {
    if (index < 0 || index >= _photoUrls.length) {
      return Container(color: Colors.grey[900]);
    }

    final url = _photoUrls[index];
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),

      memCacheWidth: 800,
      memCacheHeight: 600,
      maxHeightDiskCache: 2400,
      maxWidthDiskCache: 2400,

      placeholder: (context, url) => Container(
        color: Colors.grey[900],
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
      errorWidget: (context, url, error) {
        debugPrint('Failed to load: $url');

        // ⭐ 出錯時重新嘗試用 Image.network
        return Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[900],
              child: const Icon(
                Icons.broken_image,
                color: Colors.white54,
                size: 48,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[900],
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }

  void preloadImages(int currentIndex, BuildContext context) {
    if (_photoUrls.isEmpty) return;

    final startIndex = (currentIndex).clamp(0, _photoUrls.length - 1);
    final endIndex = (currentIndex + _preloadRange).clamp(
      0,
      _photoUrls.length - 1,
    );

    for (int i = startIndex; i <= endIndex; i++) {
      if (i == currentIndex) continue;

      final imageProvider = CachedNetworkImageProvider(
        _photoUrls[i],
        maxWidth: 1200,
        maxHeight: 800,
      );

      precacheImage(imageProvider, context).catchError((error) {
        debugPrint('Preload failed for index $i: $error');
        return null;
      });
    }
  }

  Future<void> loadPhotos(String csvUrl, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;

    Object? lastError;
    for (var attempt = 1; attempt <= _maxAttempts; attempt++) {
      try {
        final response = await http
            .get(Uri.parse(csvUrl))
            .timeout(_requestTimeout);
        if (response.statusCode != 200) {
          throw Exception('HTTP ${response.statusCode}');
        }

        final rows = const CsvToListConverter().convert(response.body);
        final photoUrls = rows
            .where((row) => row.isNotEmpty)
            .map((row) => row.first.toString().trim())
            .where((url) => url.isNotEmpty)
            .toList();
        if (photoUrls.isEmpty) {
          throw const FormatException('The cover CSV contains no image URLs.');
        }

        if (_isDisposed) return;
        _photoUrls = photoUrls;
        _isLoading = false;
        notifyListeners();
        if (context.mounted) {
          preloadImages(0, context);
        }
        return;
      } catch (error) {
        lastError = error;
        debugPrint('Cover load attempt $attempt/$_maxAttempts failed: $error');
        if (attempt < _maxAttempts) {
          await Future<void>.delayed(Duration(seconds: attempt * 2));
        }
      }
    }

    if (_isDisposed) return;
    _isLoading = false;
    _errorMessage = 'Cover photos are temporarily unavailable.';
    debugPrint(
      'Cover loading stopped after $_maxAttempts attempts: $lastError',
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _photoUrls.clear();
    super.dispose();
  }
}
