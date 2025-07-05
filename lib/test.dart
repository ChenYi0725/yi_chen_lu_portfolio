import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.black87, body: SunkenBackground()),
    );
  }
}

class SunkenBackground extends StatelessWidget {
  const SunkenBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12),
            BoxShadow(color: Colors.grey, blurRadius: 13, spreadRadius: -10.0),
          ],
        ),
        child: Icon(Icons.account_balance, color: Colors.white),
      ),
    );
  }
}
