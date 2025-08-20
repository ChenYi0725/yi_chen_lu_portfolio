import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/component/resume/resume_field.dart';
import '../../constant.dart';
import '../../provider/resume_provider.dart';
import '../../model/resume_program.dart';

enum ResumeSectionType { programs, masterElectrician, plainText }

class ResumeSection<T> extends StatelessWidget {
  const ResumeSection({
    super.key,
    required this.title,
    required this.items,
    required this.type,
  });

  final String title;
  final List<T> items;
  final ResumeSectionType type;

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
          child: Column(
            children: List.generate(items.length * 2 - 1, (index) {
              if (index.isEven) {
                final item = items[index ~/ 2];

                if (type == ResumeSectionType.masterElectrician) {
                  final List<List<String>> rows = items as List<List<String>>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: rows.map((row) {
                      return Row(
                        children: [
                          ...row.map(
                            (text) => Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(text, style: resumePureTextStyle),
                              ),
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox()), // 結尾留白空間
                        ],
                      );
                    }).toList(),
                  );
                } else if (type == ResumeSectionType.programs) {
                  if (item is ResumeProgram) {
                    return ChangeNotifierProvider(
                      create: (_) => HoverProvider(),
                      child: ResumeField(resumeProgram: item),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else if (type == ResumeSectionType.plainText) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(item.toString(), style: resumePureTextStyle),
                  );
                } else {
                  return const SizedBox.shrink(); // fallback
                }
              } else {
                return const SizedBox(height: 20);
              }
            }),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
