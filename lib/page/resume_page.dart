import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/provider/resume_provider.dart';
import '../component/header_bar.dart';
import '../component/resume/resume_section.dart';
import '../constant.dart';
import '../enum.dart';
import '../url.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResumeProvider(urls: resumeUrl)
        ..loadEducation()
        ..loadElectrician()
        ..loadLightingDesign(),
      child: Consumer<ResumeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: HeaderBar(
              currentRoute: '/resume',
              onNavItemSelected: (route) {
                context.go(route);
              },
            ),
            backgroundColor: themeColor,
            body: (!provider.loaded)
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ResumeSection(
                          title: 'LIGHTING  DESIGNER',
                          items: provider.designerPrograms,
                          type: ResumePart.lightingDesign,
                        ),
                        //---
                        ResumeSection(
                          title: 'OTHER EXPERIENCE',
                          items: provider.electrician,
                          type: ResumePart.masterElectrician,
                        ),
                        //---
                        ResumeSection(
                          title: 'EDUCATION',
                          items: provider.education,
                          type: ResumePart.education,
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
