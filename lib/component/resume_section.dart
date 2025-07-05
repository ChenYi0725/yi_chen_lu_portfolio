import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/component/resume_field.dart';
import 'package:yi_chen_lu_protfolio/model/resume_program.dart';
import '../constant.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({
    super.key,
    required this.title,
    required this.resumePrograms,
  });
  final String title;
  final List<ResumeProgram> resumePrograms;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: resumeTitleTextStyle),
        Divider(color: Colors.white, height: 2, thickness: 5),
        Column(
          children: resumePrograms
              .map((resumeProgram) => ResumeField(resumeProgram: resumeProgram))
              .toList(),
        ),
      ],
    );
  }
}
