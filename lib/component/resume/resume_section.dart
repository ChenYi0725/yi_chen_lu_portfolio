import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yi_chen_lu_protfolio/component/resume/resume_field.dart';
import 'package:yi_chen_lu_protfolio/provider/resume_field_provider.dart';
import '../../constant.dart';
import '../../enum.dart';
import '../../model/resume_program.dart';
import '../../url.dart';

class ResumeSection<T> extends StatelessWidget {
  const ResumeSection({
    super.key,
    required this.title,
    required this.items,
    required this.type,
  });

  final String title;
  final List<T> items;
  final ResumePart type;

  Future<String?> _fetchResumePdfUrl(String sheetUrl) async {
    final res = await http.get(Uri.parse(sheetUrl));
    if (res.statusCode != 200) return null;

    final lines = const LineSplitter().convert(utf8.decode(res.bodyBytes));
    return lines.isNotEmpty ? lines.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: resumePadding),
          child: Text(title, style: resumeTitleTextStyle),
        ),

        const Divider(color: Colors.white, height: 2, thickness: 3),
        const SizedBox(height: 10),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: resumePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (type == ResumePart.lightingDesign)
                ...(items as List<ResumeProgram>).map(
                  (item) => Column(
                    children: [
                      ChangeNotifierProvider(
                        create: (_) => ResumeFieldProvider(),
                        child: ResumeField(resumeProgram: item),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

              if (type == ResumePart.otherExperience)
                ...(items as List<String>).map((line) {
                  final parts = line.split(';');
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...parts.map(
                          (part) => Expanded(
                            flex: 2,
                            child: Text(
                              part,
                              style: resumePureTextStyle,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox.shrink()),
                      ],
                    ),
                  );
                }),
              if (type == ResumePart.education) ...[
                ...(items as List<String>).map((line) {
                  final parts = line.split(';');
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...parts.map(
                          (part) => Expanded(
                            flex: 2,
                            child: Text(
                              part,
                              style: resumePureTextStyle,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox.shrink(),
                        ), // 這是為了對齊用的，未來記得改掉
                        Expanded(flex: 2, child: SizedBox.shrink()),
                        Expanded(flex: 1, child: SizedBox.shrink()),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),

                FutureBuilder<String?>(
                  future: _fetchResumePdfUrl(resumePdfSheetUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }

                    final pdfUrl = snapshot.data;

                    if (pdfUrl == null || pdfUrl.isEmpty) {
                      return const SizedBox();
                    }

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => launchUrl(Uri.parse(pdfUrl)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          color: Colors.white,
                          child: Text(
                            "View Resume",
                            style: resumeRedirectStyle,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
