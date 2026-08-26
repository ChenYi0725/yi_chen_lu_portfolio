import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../url.dart';
import 'resume_pdf_button.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.items});

  final List<String> items;

  static const List<String> resumeButtonNames = ['View Resume', 'View CV'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.map((line) {
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

                const Expanded(flex: 2, child: SizedBox.shrink()),

                const Expanded(flex: 2, child: SizedBox.shrink()),

                const Expanded(flex: 1, child: SizedBox.shrink()),
              ],
            ),
          );
        }),

        const SizedBox(height: 20),

        Row(
          children: List.generate(resumeButtonNames.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                right: index < resumeButtonNames.length - 1 ? 16 : 0,
              ),
              child: ResumePdfButton(
                sheetUrl: resumePdfSheetUrl,
                text: resumeButtonNames[index],
                index: index,
              ),
            );
          }),
        ),
      ],
    );
  }
}
