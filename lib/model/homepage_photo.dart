import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/model/photo_item.dart';

class PhotoGridItem extends StatefulWidget {
  final PhotoItem photo;

  const PhotoGridItem({super.key, required this.photo});

  @override
  State<PhotoGridItem> createState() => _PhotoGridItemState();
}

class _PhotoGridItemState extends State<PhotoGridItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, widget.photo.targetRoute);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;

            return GestureDetector(
              onTap: () => print(widget.photo.title),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      widget.photo.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // 全覆蓋黑色遮罩
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: 0,
                    right: 0,
                    bottom: _hover ? 0 : -height,
                    height: height,
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      alignment: Alignment.center,
                      child: Text(
                        widget.photo.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
