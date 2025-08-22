import 'package:flutter/material.dart';

class ResponsiveProvider extends ChangeNotifier {
  final BuildContext context;

  ResponsiveProvider(this.context);

  bool get isMobile =>
      MediaQuery.of(context).size.width <
      MediaQuery.of(context).size.height * 1.1;
}
