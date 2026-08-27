import 'package:flutter/material.dart';

import '../../constant.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({
    super.key,
    required this.title,
    required this.child,
    this.isEmpty = false,
  });

  final String title;
  final Widget child;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const SizedBox.shrink();
    }

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
