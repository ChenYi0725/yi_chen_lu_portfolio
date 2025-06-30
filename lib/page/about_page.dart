import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/string_content.dart';
import '../component/header_bar.dart';
import '../constant.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        currentRoute: '/about',
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      backgroundColor: themeColor,
      body: Column(
        children: [
          Text(aboutPageContent, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
