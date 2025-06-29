import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/model/photo_model.dart';

class PhotoGridItem extends StatefulWidget {
  final Photo photo;

  const PhotoGridItem({super.key, required this.photo});

  @override
  State<PhotoGridItem> createState() => _PhotoGridItemState();
}

class _PhotoGridItemState extends State<PhotoGridItem>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;
  Offset _translation = Offset.zero;
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        final size = context.size ?? Size.zero;
        final offset = event.localPosition;
        setState(() {
          _hovering = true;
          _translation = _getDirectionOffset(offset, size);
          _opacity = 1.0;
        });

        // 等下一幀再讓它移回中心，達到動畫效果
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _translation = Offset.zero;
          });
        });
      },
      onExit: (event) {
        final size = context.size ?? Size.zero;
        final offset = event.localPosition;
        setState(() {
          _translation = _getDirectionOffset(offset, size);
          _opacity = 0.0;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, widget.photo.targetRoute);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                widget.photo.coverImagePath,
                fit: BoxFit.cover,
              ),
            ),
            // 黑色遮罩
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 300),
                child: AnimatedFractionalTranslation(
                  translation: _translation,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                    alignment: Alignment.center,
                    child: Text(
                      widget.photo.title,
                      style: const TextStyle(color: Colors.white, fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Offset _getDirectionOffset(Offset pos, Size size) {
    final x = pos.dx;
    final y = pos.dy;
    final width = size.width;
    final height = size.height;

    if (x < width * 0.25) return const Offset(-1, 0); // from left
    if (x > width * 0.75) return const Offset(1, 0); // from right
    if (y < height * 0.25) return const Offset(0, -1); // from top
    if (y > height * 0.75) return const Offset(0, 1); // from bottom

    return const Offset(0, 1); // default from bottom
  }
}

class AnimatedFractionalTranslation extends ImplicitlyAnimatedWidget {
  final Offset translation;
  final Widget child;

  const AnimatedFractionalTranslation({
    super.key,
    required this.translation,
    required Duration duration,
    required this.child,
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve);

  @override
  AnimatedFractionalTranslationState createState() =>
      AnimatedFractionalTranslationState();
}

class AnimatedFractionalTranslationState
    extends AnimatedWidgetBaseState<AnimatedFractionalTranslation> {
  Tween<Offset>? _translation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _translation =
        visitor(
              _translation,
              widget.translation,
              (dynamic value) => Tween<Offset>(begin: value as Offset),
            )
            as Tween<Offset>?;
  }

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: _translation!.evaluate(animation),
      child: widget.child,
    );
  }
}
