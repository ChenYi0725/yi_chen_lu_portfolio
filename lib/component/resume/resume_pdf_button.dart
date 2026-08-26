import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';

class ResumePdfButton extends StatelessWidget {
  const ResumePdfButton({
    super.key,
    required this.sheetUrl,
    required this.text,
    required this.index,
  });

  final String sheetUrl;
  final String text;
  final int index;

  Future<String?> _fetchPdfUrl() async {
    final res = await http.get(Uri.parse(sheetUrl));

    if (res.statusCode != 200) {
      return null;
    }

    final csvText = utf8.decode(res.bodyBytes);
    final rows = const CsvToListConverter().convert(csvText);

    // 只保留 B 欄有資料的 row
    final urls = rows
        .where((row) => row.length >= 2)
        .map((row) => row[1].toString().trim())
        .where((url) => url.isNotEmpty)
        .toList();

    if (index >= urls.length) {
      return null;
    }

    return urls[index];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _fetchPdfUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 48,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        final pdfUrl = snapshot.data;

        if (pdfUrl == null || pdfUrl.isEmpty) {
          return const SizedBox();
        }

        return InkWell(
          onTap: () async {
            await launchUrl(
              Uri.parse(pdfUrl),
              mode: LaunchMode.externalApplication,
            );
          },
          child: Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            alignment: Alignment.center,
            color: Colors.white,
            child: Text(
              text,
              style: resumeRedirectStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
