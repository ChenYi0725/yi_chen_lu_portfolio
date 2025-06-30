import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../component/header_bar.dart';
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
      body: Column(children: []),
    );
  }
}
