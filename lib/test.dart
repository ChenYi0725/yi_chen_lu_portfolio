import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/photo_list.dart';
import 'model/photo_grid.dart';
import 'model/photo_model.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GridItemExpansionWithArrow(photoList: dancePhoto));
  }
}

class GridItemExpansionWithArrow extends StatefulWidget {
  const GridItemExpansionWithArrow({super.key, required this.photoList});
  final List<Photo> photoList;
  @override
  _GridItemExpansionWithArrowState createState() =>
      _GridItemExpansionWithArrowState();
}

class _GridItemExpansionWithArrowState extends State<GridItemExpansionWithArrow>
    with TickerProviderStateMixin {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = 8.0 * 2;
    final cardSpacing = 0.0;
    final cardWidth = (screenWidth - paddingHorizontal - cardSpacing) / 3;

    for (int i = 0; i < widget.photoList.length; i += 3) {
      final rowItems = widget.photoList.sublist(
        i,
        (i + 3 > widget.photoList.length) ? widget.photoList.length : i + 3,
      );

      rowWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            children: List.generate(3, (j) {
              if (j >= rowItems.length) {
                return const Expanded(child: SizedBox());
              }

              int actualIndex = i + j;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      expandedIndex = (expandedIndex == actualIndex)
                          ? null
                          : actualIndex;
                    });
                  },
                  child: PhotoGridItem(photo: widget.photoList[actualIndex]),
                ),
              );
            }),
          ),
        ),
      );

      // 展開詳細區域 (永遠佔位，但動畫呈現)
      int tappedIndexInRow = expandedIndex != null ? expandedIndex! - i : 0;
      bool shouldShowDetail =
          expandedIndex != null &&
          expandedIndex! >= i &&
          expandedIndex! < i + 3;

      rowWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: shouldShowDetail
                ? Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('這是第 $expandedIndex 個項目的詳細內容'),
                      ),
                      Positioned(
                        top: 0,
                        left: tappedIndexInRow * cardWidth + cardWidth / 2 - 10,
                        child: Transform.rotate(
                          angle: 3.1416,
                          child: ClipPath(
                            clipper: TriangleClipper(),
                            child: Container(
                              width: 20,
                              height: 10,
                              color: Colors.yellow[100],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(height: 0), // 保留空間但不顯示
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('精準箭頭定位')),
      body: ListView(children: rowWidgets),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
