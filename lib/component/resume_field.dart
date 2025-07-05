import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/model/resume_program.dart';

class ResumeField extends StatelessWidget {
  const ResumeField({super.key, required this.resumeProgram});
  final ResumeProgram resumeProgram;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(resumeProgram.programName),
        Text(resumeProgram.directorName),
        Text(resumeProgram.performanceVenues),
        Text(resumeProgram.performanceLocation),
        Text(resumeProgram.programLink),
      ],
    );
  }
}
