import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/repository/image_content_repository.dart';
import 'package:yi_chen_lu_protfolio/repository/string_content_repository.dart';
import '../component/header_bar.dart';
import '../constant.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<StringContentRepository>(context);
    final imageRepo = Provider.of<ImageContentRepository>(context);

    if (!repo.loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!imageRepo.loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final contentList = repo.getPageContent('about');

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
                child: Image.network(
                  imageRepo.getImage('about'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(contentList.join('\n'), style: aboutTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
