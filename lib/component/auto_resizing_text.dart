import 'package:flutter/cupertino.dart';

class AutoResizingText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const AutoResizingText({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 10,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = style.fontSize ?? 14;
        double maxFontSize = 100;

        while (fontSize > 8) {
          final textPainter = TextPainter(
            text: TextSpan(
              text: text,
              style: style.copyWith(fontSize: fontSize),
            ),
            maxLines: maxLines,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);

          if (textPainter.didExceedMaxLines ||
              textPainter.height > constraints.maxHeight) {
            fontSize -= 1;
          } else {
            break;
          }
        }

        return Text(
          text,
          style: style.copyWith(fontSize: fontSize * 0.65),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
