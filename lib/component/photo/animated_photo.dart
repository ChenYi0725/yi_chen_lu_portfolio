import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';
import 'package:yi_chen_lu_protfolio/model/photo_model.dart';

class AnimatedPhoto extends StatefulWidget {
  final Photo photo;

  const AnimatedPhoto({super.key, required this.photo});

  @override
  State<AnimatedPhoto> createState() => _AnimatedPhotoState();
}

class _AnimatedPhotoState extends State<AnimatedPhoto>
    with SingleTickerProviderStateMixin {
  Offset _translation = Offset.zero;
  double _opacity = 0.0;
  Offset? _mousePosition;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        final size = context.size ?? Size.zero; //widget size
        final mouseEnterPosition = event.localPosition;
        setState(() {
          _mousePosition = mouseEnterPosition;
          _translation = _getDirectionOffset(_mousePosition!, size);
          _opacity = 1.0;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _translation = Offset.zero;
          });
        });
      },
      onExit: (event) {
        final size = context.size ?? Size.zero;
        final mouseEnterPosition = event.localPosition;
        setState(() {
          _mousePosition = null; // 離開時隱藏
          _translation = _getDirectionOffset(mouseEnterPosition, size);
          _opacity = 0.0;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _translation = Offset.zero;
            });
          }
        });
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.grey),

                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    widget.photo.coverImagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
          ),

          Positioned.fill(
            child: ClipRect(
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
                      style: animatedPhotoStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Offset _getDirectionOffset(Offset position, Size size) {
    final w = size.width;
    final h = size.height;
    final dx = position.dx - w / 2; //滑鼠相對於中心點的距離
    final dy = position.dy - h / 2;

    final slope1 = h / w;
    final slope2 = -h / w;

    if (dy >= slope1 * dx && dy <= slope2 * dx) {
      return const Offset(-1, 0); // left   -1,0
    } else if (dy >= slope1 * dx && dy >= slope2 * dx) {
      return const Offset(0, 1); // button     0,1
    } else if (dy <= slope1 * dx && dy >= slope2 * dx) {
      return const Offset(1, 0); // right     1,0
    } else if (dy <= slope1 * dx && dy <= slope2 * dx) {
      return const Offset(0, -1); // top   0,-1
    }
    return const Offset(0, 0);
  }
}

class AnimatedFractionalTranslation extends ImplicitlyAnimatedWidget {
  final Offset translation;
  final Widget child;

  const AnimatedFractionalTranslation({
    super.key,
    required this.translation,
    required super.duration,
    required this.child,
    super.curve,
  });

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
