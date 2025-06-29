import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/header_bar.dart';
import '../constant.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        currentRoute: '/contact',
        onNavItemSelected: (route) {
          context.go(route); // 如果你有用 go_router
        },
      ),
      backgroundColor: themeColor,
      body: Column(children: []),
    );
  }
}
