import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yi_chen_lu_protfolio/model/resume_program.dart';

import '../../constant.dart';

class ResumeField extends StatelessWidget {
  const ResumeField({super.key, required this.resumeProgram});
  final ResumeProgram resumeProgram;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('無法開啟 $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(resumeProgram.programName, style: resumeTextStyle),
        ),
        SizedBox(height: 50),
        Expanded(
          child: Text(resumeProgram.directorName, style: resumeTextStyle),
        ),
        SizedBox(height: 50),
        Expanded(
          child: Text(resumeProgram.performanceVenues, style: resumeTextStyle),
        ),
        Expanded(
          child: Text(
            resumeProgram.performanceLocation,
            style: resumeTextStyle,
          ),
        ),
        resumeProgram.programLink != ''
            ? GestureDetector(
                onTap: () {
                  _launchUrl(resumeProgram.programLink);
                },
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    color: Colors.white,
                    child: Text(
                      "View Project",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              )
            : SizedBox(height: 0),
      ],
    );
  }
}
