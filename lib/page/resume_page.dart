import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/resume_list.dart';
import '../component/header_bar.dart';
import '../component/resume_section.dart';
import '../constant.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        currentRoute: '/resume',
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      backgroundColor: themeColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ResumeSection(
              title: 'LIGHTING DESIGNER',
              items: resumeProgramItems,
            ),
            ResumeSection(
              title: 'MASTER ELETRICTIAN',
              items: resumeElectrician,
            ),
            ResumeSection(title: 'LIGHTING DESIGNER', items: resumeEducation),
          ],
        ),
      ),
    );
  }
}
