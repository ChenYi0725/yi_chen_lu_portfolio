import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../component/header_bar.dart';
import '../constant.dart';
import '../string_content.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        currentRoute: '/contact',
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      backgroundColor: themeColor,
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/images/cover/cover (3).jpg'),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(contactPageContent, style: contactTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
