import 'package:flutter/material.dart';

class RenderController {
  int calculateTextLines(String text, TextStyle style, double maxWidth) {
    final span = TextSpan(text: text, style: style);
    final tp = TextPainter(
      text: span,
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: maxWidth);
    return tp.computeLineMetrics().length;
  }
}
