import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/provider/responsive_provider.dart';
import 'package:yi_chen_lu_protfolio/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => ResponsiveProvider(context),
        child: MaterialApp.router(
          theme: ThemeData(
            primarySwatch: Colors.grey,
            scaffoldBackgroundColor: Colors.grey,
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: Colors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: "Yi-Chen Lu | Lighting Designer",
        ),
      ),
    );
  }
}
