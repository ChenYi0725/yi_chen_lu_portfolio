import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../enum.dart';
import '../model/photo_model.dart';

class GalleryProvider extends ChangeNotifier {
  static final Map<String, _GalleryCacheEntry> _cache = {};
  static const Duration _cacheLifetime = Duration(minutes: 10);
  static const Duration _requestTimeout = Duration(seconds: 12);
  static const int _maxAttempts = 4;

  final String url;
  final GalleryType type;

  List<Photo> photos = [];
  bool isLoading = false;
  bool hasLoadedOnce = false;

  GalleryProvider({required this.url, required this.type});

  String get _cacheKey => '${type.name}:$url';

  Future<void> fetchPhotos({bool forceRefresh = false}) async {
    final cached = _cache[_cacheKey];
    if (!forceRefresh &&
        cached != null &&
        DateTime.now().difference(cached.loadedAt) < _cacheLifetime) {
      photos = cached.photos;
      hasLoadedOnce = true;
      isLoading = false;
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    Object? lastError;
    for (var attempt = 1; attempt <= _maxAttempts; attempt++) {
      try {
        final response = await http
            .get(Uri.parse(url))
            .timeout(_requestTimeout);

        if (response.statusCode != 200) {
          throw Exception('HTTP ${response.statusCode}');
        }

        final decoded = utf8.decode(response.bodyBytes);
        final rows = const CsvToListConverter().convert(decoded);
        final dataRows = rows.skip(1).toList();

        final loadedPhotos = dataRows
            .map((row) {
              final data = row.toList();

              switch (type) {
                case GalleryType.gallery:
                  return Photo(
                    title: data[0].toString(),
                    description: data[1].toString(),
                    coverImagePath: data[2].toString().trim(),
                    contentImages: data[3]
                        .toString()
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList(),
                  );

                case GalleryType.url:
                  return Photo(
                    title: data[0].toString(),
                    coverImagePath: data[1].toString().trim(),
                    description: '',
                    url: data.length > 2 ? data[2].toString().trim() : null,
                  );
              }
            })
            .toList(growable: false);

        photos = loadedPhotos;
        _cache[_cacheKey] = _GalleryCacheEntry(loadedPhotos, DateTime.now());
        hasLoadedOnce = true;
        isLoading = false;
        notifyListeners();
        return;
      } catch (error) {
        lastError = error;
        debugPrint(
          'Gallery load attempt $attempt/$_maxAttempts failed: $error',
        );

        if (attempt < _maxAttempts) {
          await Future<void>.delayed(Duration(seconds: attempt * 2));
        }
      }
    }

    // If a refresh fails, stale data is still better than an empty gallery.
    if (cached != null) {
      photos = cached.photos;
      hasLoadedOnce = true;
    }
    isLoading = false;
    debugPrint('Gallery loading stopped: $lastError');
    notifyListeners();
  }

  Future<void> reload() async {
    await fetchPhotos(forceRefresh: true);
  }
}

class _GalleryCacheEntry {
  const _GalleryCacheEntry(this.photos, this.loadedAt);

  final List<Photo> photos;
  final DateTime loadedAt;
}
