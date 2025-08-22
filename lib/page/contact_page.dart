import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../component/header_bar.dart';
import '../constant.dart';
import '../provider/contact_and_about_provider.dart';
import '../provider/responsive_provider.dart';
import '../url.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Provider.of<ResponsiveProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) =>
          ContactAndAboutProvider(sheetCsvUrl: aboutAndContactUrl)..loadData(),
      child: Consumer<ContactAndAboutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: HeaderBar(
              currentRoute: '/contact',
              onNavItemSelected: (route) {
                context.go(route);
              },
            ),
            backgroundColor: themeColor,
            body: (!provider.loaded)
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Text(
                          provider.contactText,
                          style: contactTextStyle,
                        ),
                      ),
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print(responsive.isMobile);
              },
            ),
          );
        },
      ),
    );
  }
}
