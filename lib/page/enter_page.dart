import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';
import 'package:yi_chen_lu_protfolio/page/home_page.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key});

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoFade();
  }

  void _startAutoFade() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % entryPageCarouselList.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = entryPageCarouselList[_currentIndex];
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // 淡入淡出圖片背景
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: Image.asset(
                image,
                key: ValueKey(image),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 黑色遮罩（可選）
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          Positioned(
            top: screenWidth * 0.05,
            left: screenWidth * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Yi Chen Lu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'LIGHTING DESIGN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                      border: Border.all(color: Colors.white, width: 2),
                      // borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'ENTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
