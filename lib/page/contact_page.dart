import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../component/header_bar.dart';
import '../constant.dart';
import '../repository/string_content_repository.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<StringContentRepository>(context);

    if (!repo.loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final contentList = repo.getPageContent('contact');
    return Scaffold(
      appBar: HeaderBar(
        currentRoute: '/contact',
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      backgroundColor: themeColor,
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            child: Text(contentList.join('\n'), style: contactTextStyle),
          ),
        ),
      ),
    );
  }
}
