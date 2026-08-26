import 'package:flutter/material.dart';

import '../../constant.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

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
          child: child,
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
