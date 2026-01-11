import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class CoverProvider extends ChangeNotifier {
  List<String> _photoUrls = [];
  bool _isLoading = true;

  // ⭐ 預載範圍：當前圖片的前後各 3 張
  static const int _preloadRange = 3;

  List<String> get photoUrls => _photoUrls;
  bool get isLoading => _isLoading;
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

      httpHeaders: const {'Connection': 'keep-alive'},

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
    try {
      final response = await http.get(Uri.parse(csvUrl));
      if (response.statusCode == 200) {
        final csvBody = response.body;
        final rows = const CsvToListConverter().convert(csvBody);

        // ✅ 只存網址
        _photoUrls = rows.map((row) => row[0].toString()).toList();

        _isLoading = false;
        notifyListeners();

        // ⭐ 載入完成後，預載前幾張圖片
        if (_photoUrls.isNotEmpty) {
          preloadImages(0, context);
        }
      } else {
        debugPrint('Failed to load CSV: ${response.statusCode}');
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching CSV: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _photoUrls.clear();
    super.dispose();
  }
}
