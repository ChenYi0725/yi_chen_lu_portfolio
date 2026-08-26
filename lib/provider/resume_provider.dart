import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:yi_chen_lu_protfolio/model/resume_program.dart';

import '../enum.dart';

class ResumeProvider with ChangeNotifier {
  List<String> education = [];

  List<String> associateExperience = [];
  List<String> otherLightingExperience = [];

  List<ResumeProgram> designerPrograms = [];

  final Map<ResumePart, String> urls;

  ResumeProvider({required this.urls});

  bool get loaded =>
      education.isNotEmpty &&
      associateExperience.isNotEmpty &&
      otherLightingExperience.isNotEmpty;
  // 如果之後 DESIGN EXPERIENCE 也一定要載入完成，
  // 可以再加：
  // && designerPrograms.isNotEmpty;

  Future<List<List<dynamic>>?> _fetchCsv(ResumePart type) async {
    try {
      final url = urls[type];

      if (url == null) {
        debugPrint('URL not found for $type');
        return null;
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        debugPrint('Failed to load CSV for $type: ${response.statusCode}');
        return null;
      }

      final decoded = utf8.decode(response.bodyBytes);

      final rows = const CsvToListConverter().convert(decoded);

      return rows;
    } catch (e) {
      debugPrint('Error fetching CSV for $type: $e');

      return null;
    }
  }

  Future<void> loadEducation() async {
    final rows = await _fetchCsv(ResumePart.education);

    if (rows == null) {
      return;
    }

    education = rows
        .skip(1)
        .where((row) => row.isNotEmpty)
        .map((row) => row[0].toString())
        .toList();

    notifyListeners();
  }

  Future<void> loadAssociateExperience() async {
    final rows = await _fetchCsv(ResumePart.associateExperience);

    if (rows == null) {
      return;
    }

    associateExperience = rows
        .skip(1)
        .where((row) => row.isNotEmpty)
        .map((row) => row[0].toString())
        .toList();

    notifyListeners();
  }

  Future<void> loadOtherLightingExperience() async {
    final rows = await _fetchCsv(ResumePart.otherExperience);

    if (rows == null) {
      return;
    }

    otherLightingExperience = rows
        .skip(1)
        .where((row) => row.isNotEmpty)
        .map((row) => row[0].toString())
        .toList();

    notifyListeners();
  }

  Future<void> loadLightingDesign() async {
    final rows = await _fetchCsv(ResumePart.lightingDesign);

    if (rows == null) {
      return;
    }

    final dataRows = rows.skip(1).toList();

    designerPrograms = dataRows.where((row) => row.length >= 6).map((row) {
      final data = row.toList();

      return ResumeProgram(
        programName: data[0].toString(),
        directorsName: data[1]
            .toString()
            .split(';')
            .map((e) => e.trim())
            .toList(),
        performanceVenues: data[2].toString(),
        performanceLocation: data[3].toString(),
        programLink: data[4].toString(),
        isOutsideUrl: data[5].toString().toLowerCase() == 'true',
      );
    }).toList();

    notifyListeners();
  }

  Future<void> loadAll() async {
    await Future.wait([
      loadEducation(),
      loadAssociateExperience(),
      loadOtherLightingExperience(),
      loadLightingDesign(),
    ]);
  }
}
