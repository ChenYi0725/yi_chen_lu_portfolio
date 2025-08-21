import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../component/header_bar.dart';
import '../constant.dart';
import '../provider/contact_and_about_provider.dart';
import '../url.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ContactAndAboutProvider(sheetCsvUrl: aboutAndContactUrl)..loadData(),
      child: Consumer<ContactAndAboutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: HeaderBar(
              currentRoute: '/about',
              onNavItemSelected: (route) {
                context.go(route);
              },
            ),
            backgroundColor: themeColor,
            body: (!provider.loaded)
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.network(provider.aboutImageUrl),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Text(
                                provider.aboutText,
                                style: aboutTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
