import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/page/enter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "protfolio",
      home: const Scaffold(body: SafeArea(child: EnterPage())),
    );
  }
}
