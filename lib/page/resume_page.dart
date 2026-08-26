import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../component/header_bar.dart';
import '../component/resume/education_section.dart';
import '../component/resume/experience_section.dart';
import '../component/resume/lighting_design_section.dart';
import '../component/resume/resume_section.dart';
import '../constant.dart';
import '../provider/resume_provider.dart';
import '../url.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResumeProvider(urls: resumeUrl)..loadAll(),

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
            body: !provider.loaded
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ResumeSection(
                          title: 'DESIGN EXPERIENCE',
                          child: LightingDesignSection(
                            items: provider.designerPrograms,
                          ),
                        ),

                        ResumeSection(
                          title: 'ASSOCIATE/ASSISTANT EXPERIENCE',
                          child: ExperienceSection(
                            items: provider.associateExperience,
                          ),
                        ),

                        ResumeSection(
                          title: 'OTHER LIGHTING EXPERIENCE',
                          child: ExperienceSection(
                            items: provider.otherLightingExperience,
                          ),
                        ),

                        ResumeSection(
                          title: 'EDUCATION',
                          child: EducationSection(items: provider.education),
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
