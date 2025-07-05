import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/component/animated_photo.dart';
import 'package:yi_chen_lu_protfolio/component/photo_detail.dart';

import '../controller/photo_expansion_controller.dart';
import '../model/photo_model.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key, required this.photoList});
  final List<Photo> photoList;
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with TickerProviderStateMixin {
  late final PhotoExpansionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PhotoExpansionController();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    _controller.toggle(index: actualIndex, row: i);
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 300,
                      child: AnimatedPhoto(
                        photo: widget.photoList[actualIndex],
                      ),
                    ),
                  ),
                  //
                ),
              );
            }),
          ),
        ),
      );
      //-----
      //detail
      int tappedIndexInRow = _controller.expandedIndex != null
          ? _controller.expandedIndex! - i
          : 0;
      bool shouldShowDetail =
          _controller.expandedIndex != null &&
          _controller.expandedIndex! >= i &&
          _controller.expandedIndex! < i + 3;

      rowWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: shouldShowDetail
                ? PhotoDetail(
                    photo: widget.photoList[_controller.expandedIndex!],
                    indicatorOffset:
                        tappedIndexInRow * cardWidth + cardWidth / 2 - 10,
                  )
                : const SizedBox(height: 0),
          ),
        ),
      );
    }

    return Column(children: rowWidgets);
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
