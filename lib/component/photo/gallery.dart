import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/photo_expansion_controller.dart';
import '../../model/photo_model.dart';
import '../../provider/responsive_provider.dart';
import 'animated_photo.dart';
import 'photo_detail.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key, required this.photoList, this.initialExpandIndex});

  final List<Photo> photoList;
  final int? initialExpandIndex;

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with TickerProviderStateMixin {
  late final PhotoExpansionController _controller;
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _photoKeys = {}; // 每張圖對應的 key

  int _getImagePerRow() {
    final isMobile = context.read<ResponsiveProvider>().isMobile;
    return isMobile ? 2 : 3;
  }

  @override
  void initState() {
    super.initState();
    _controller = PhotoExpansionController();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });

    if (widget.initialExpandIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final targetIndex = widget.initialExpandIndex!;
        _controller.toggle(
          index: targetIndex,
          row: targetIndex ~/ _getImagePerRow() * _getImagePerRow(),
        );

        await Future.delayed(const Duration(milliseconds: 300));

        final key = _photoKeys[targetIndex];
        if (key != null && key.currentContext != null) {
          await Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignment: -1,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagePerRow = _getImagePerRow();

    return LayoutBuilder(
      builder: (context, constraints) {
        final constraintWidth = constraints.maxWidth;
        final paddingHorizontal = 8.0 * (imagePerRow + 1) * 2;
        final photoWidth = (constraintWidth - paddingHorizontal) / imagePerRow;
        final photoHeight = photoWidth * 2 / imagePerRow;

        List<Widget> rowWidgets = [];

        for (int i = 0; i < widget.photoList.length; i += imagePerRow) {
          final rowItems = widget.photoList.sublist(
            i,
            (i + imagePerRow > widget.photoList.length)
                ? widget.photoList.length
                : i + imagePerRow,
          );

          rowWidgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(imagePerRow, (j) {
                  if (j >= rowItems.length) {
                    return SizedBox(width: photoWidth, height: photoHeight);
                  }

                  int actualIndex = i + j;

                  _photoKeys.putIfAbsent(actualIndex, () => GlobalKey());

                  return GestureDetector(
                    onTap: () {
                      _controller.toggle(index: actualIndex, row: i);

                      final key = _photoKeys[actualIndex];
                      if (key != null && key.currentContext != null) {
                        Scrollable.ensureVisible(
                          key.currentContext!,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        key: _photoKeys[actualIndex],
                        height: photoHeight,
                        width: photoWidth,
                        child: AnimatedPhoto(
                          photo: widget.photoList[actualIndex],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );

          // 展開 detail
          final tappedIndexInRow = _controller.expandedIndex != null
              ? _controller.expandedIndex! - i
              : 0;
          final shouldShowDetail =
              _controller.expandedIndex != null &&
              _controller.expandedIndex! >= i &&
              _controller.expandedIndex! < i + imagePerRow;

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
                            tappedIndexInRow * photoWidth + photoWidth / 2 - 10,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          );
        }

        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: rowWidgets),
        );
      },
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
