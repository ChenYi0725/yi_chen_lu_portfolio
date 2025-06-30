import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/page/home_page.dart';
import 'package:yi_chen_lu_protfolio/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: "protfolio",
    );
  }
}
