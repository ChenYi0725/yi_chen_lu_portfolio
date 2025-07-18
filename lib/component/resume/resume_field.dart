import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yi_chen_lu_protfolio/model/resume_program.dart';
import '../../constant.dart';
import '../../controller/resume_provider.dart';

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
    final hover = context.watch<HoverProvider>().isHovering;

    return MouseRegion(
      onEnter: (_) => context.read<HoverProvider>().setHover(true),
      onExit: (_) => context.read<HoverProvider>().setHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // color: hover ? Colors.grey.shade50 : Colors.transparent,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(resumeProgram.programName, style: resumeTextStyle),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  children: List.generate(resumeProgram.directorsName.length, (
                    index,
                  ) {
                    String name = resumeProgram.directorsName[index];
                    String display =
                        (index != resumeProgram.directorsName.length - 1)
                        ? "$name, "
                        : name;
                    return Text(display, style: resumeTextStyle);
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  resumeProgram.performanceVenues,
                  style: resumeTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  resumeProgram.performanceLocation,
                  style: resumeTextStyle,
                ),
              ),
            ),
            // if (resumeProgram.programLink.isNotEmpty && hover)
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: hover ? 1.0 : 0.0,
                child: InkWell(
                  onTap: () => _launchUrl(resumeProgram.programLink),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    color: Colors.white,
                    child: Center(
                      child: Text("View Project", style: resumeRedirectStyle),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
