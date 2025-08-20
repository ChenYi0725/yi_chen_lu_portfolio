import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/repository/image_content_repository.dart';
import 'package:yi_chen_lu_protfolio/router.dart';
import 'package:yi_chen_lu_protfolio/repository/string_content_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.grey,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: "protfolio",
      ),
    );
  }
}
