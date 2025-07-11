import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/photo_list.dart';
import 'package:yi_chen_lu_protfolio/string_content.dart';
import '../component/auto_resizing_text.dart';
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
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(aboutPhoto),
              ),
            ),

            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(aboutPageContent, style: aboutTextStyle),
                // AutoResizingText(
                //   text: aboutPageContent,
                //   style: aboutTextStyle,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
