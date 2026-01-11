import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class CoverProvider extends ChangeNotifier {
  List<String> _photoUrls = [];
  final List<Widget> _photos = [];
  bool _isLoading = true;

  List<String> get photoUrls => _photoUrls;
  List<Widget> get photos => _photos;
  bool get isLoading => _isLoading;

  Future<void> loadPhotos(String csvUrl, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(csvUrl));
      if (response.statusCode == 200) {
        final csvBody = response.body;
        final rows = const CsvToListConverter().convert(csvBody);

        _photoUrls = rows.map((row) => row[0].toString()).toList();
        _photos.clear();

        // 使用 Image.network 並加入錯誤處理
        for (var url in _photoUrls) {
          _photos.add(
            CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 500),
              fadeOutDuration: const Duration(milliseconds: 500),
              placeholder: (context, url) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
              errorWidget: (context, url, error) {
                debugPrint('Failed to load: $url');
                return Container(
                  color: Colors.grey[900],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 48,
                  ),
                );
              },
              // 自動重試設定
              maxHeightDiskCache: 1000,
              maxWidthDiskCache: 1000,
            ),
          );
        }

        _isLoading = false;
        notifyListeners();
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
}
