import 'package:flutter/material.dart';

class CenterInWideScreen extends StatelessWidget {
  CenterInWideScreen({super.key, required this.child});
  final Widget child;
  final double screenWidthRatio = 0.6;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenWidth * screenWidthRatio),
        child: child,
      ),
    );
  }
}
