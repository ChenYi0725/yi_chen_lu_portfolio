import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/resume_program.dart';
import '../../provider/resume_field_provider.dart';
import 'resume_field.dart';

class LightingDesignSection extends StatelessWidget {
  const LightingDesignSection({super.key, required this.items});

  final List<ResumeProgram> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Column(
          children: [
            ChangeNotifierProvider(
              create: (_) => ResumeFieldProvider(),
              child: ResumeField(resumeProgram: item),
            ),

            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }
}
