import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:yi_chen_lu_protfolio/model/resume_program.dart';
import '../enum.dart';

class ResumeProvider with ChangeNotifier {
  List<String> education = [];
  List<String> electrician = [];
  List<ResumeProgram> designerPrograms = [];
  bool get loaded =>
      // designerPrograms.isNotEmpty &&
      electrician.isNotEmpty && education.isNotEmpty;

  final Map<ResumePart, String> urls;
  ResumeProvider({required this.urls});

  Future<void> loadEducation() async {
    try {
      final response = await http.get(Uri.parse(urls[ResumePart.education]!));
      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final rows = const CsvToListConverter().convert(decoded);
        education = rows.map((row) => row[0].toString()).skip(1).toList();
        notifyListeners();
      } else {
        debugPrint('Failed to load CSV: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching CSV: $e');
    }
  }

  Future<void> loadElectrician() async {
    try {
      final response = await http.get(
        Uri.parse(urls[ResumePart.otherExperience]!),
      );
      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final rows = const CsvToListConverter().convert(decoded);
        electrician = rows.map((row) => row[0].toString()).skip(1).toList();
        notifyListeners();
      } else {
        debugPrint('Failed to load CSV: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching CSV: $e');
    }
  }

  Future<void> loadLightingDesign() async {
    try {
      final response = await http.get(
        Uri.parse(urls[ResumePart.lightingDesign]!),
      );
      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final rows = const CsvToListConverter().convert(decoded);
        final dataRows = rows.skip(1).toList();

        designerPrograms = dataRows.map((row) {
          final data = row.toList();
          return ResumeProgram(
            programName: data[0].toString(),
            directorsName: data[1]
                .toString()
                .split(";")
                .map((e) => e.trim())
                .toList(),
            performanceVenues: data[2].toString(),
            performanceLocation: data[3].toString(),
            programLink: data[4].toString(),
            isOutsideUrl: data[5].toString().toLowerCase() == 'true',
          );
        }).toList();

        notifyListeners();
      } else {
        debugPrint('Failed to load CSV: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching CSV: $e');
    }
  }
}
