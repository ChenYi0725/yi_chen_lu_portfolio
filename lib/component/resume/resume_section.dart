import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/component/resume/resume_field.dart';
import 'package:yi_chen_lu_protfolio/provider/resume_field_provider.dart';
import '../../constant.dart';
import '../../enum.dart';
import '../../model/resume_program.dart';

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
              if (type == ResumePart.masterElectrician)
                ...(items as List<String>).map(
                  (text) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(text, style: resumePureTextStyle),
                  ),
                ),

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

              if (type == ResumePart.education)
                ...(items as List<String>).map(
                  (text) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(text, style: resumePureTextStyle),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
