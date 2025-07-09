import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/component/resume/resume_field.dart';
import '../../constant.dart';
import '../../controller/resume_provider.dart';
import '../../model/resume_program.dart';

class ResumeSection<T> extends StatelessWidget {
  const ResumeSection({super.key, required this.title, required this.items});

  final String title;
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: resumePadding, right: resumePadding),
          child: Text(title, style: resumeTitleTextStyle),
        ),
        const Divider(color: Colors.white, height: 2, thickness: 3),
        Padding(
          padding: EdgeInsets.only(left: resumePadding, right: resumePadding),
          child: Column(
            children: List.generate(items.length * 2 - 1, (index) {
              if (index.isEven) {
                final item = items[index ~/ 2];
                if (item is ResumeProgram) {
                  return ChangeNotifierProvider(
                    create: (_) => HoverProvider(),
                    child: ResumeField(resumeProgram: item),
                  );
                } else if (item is String) {
                  //純文字
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return const SizedBox(height: 30); // 或你要的 spacing 高度
              }
            }),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
