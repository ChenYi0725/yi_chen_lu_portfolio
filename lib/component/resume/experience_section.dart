import 'package:flutter/material.dart';

import '../../constant.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((line) {
        final parts = line.split(';');

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              ...parts.map(
                (part) => Expanded(
                  flex: 2,
                  child: Text(part, style: resumePureTextStyle),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox.shrink()),
            ],
          ),
        );
      }).toList(),
    );
  }
}
