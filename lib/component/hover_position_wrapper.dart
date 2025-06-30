import 'package:flutter/material.dart';

/// 可偵測滑鼠進入方向並做位移展開的 Widget
class HoverPositionWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offsetDistance;

  const HoverPositionWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.offsetDistance = 20,
  });

  @override
  State<HoverPositionWrapper> createState() => _HoverPositionWrapperState();
}

enum HoverDirection { left, right, top, bottom, center }

class _HoverPositionWrapperState extends State<HoverPositionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  HoverDirection _enterDirection = HoverDirection.center;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _directionToOffset(HoverDirection dir) {
    switch (dir) {
      case HoverDirection.left:
        return Offset(-widget.offsetDistance / context.size!.width, 0);
      case HoverDirection.right:
        return Offset(widget.offsetDistance / context.size!.width, 0);
      case HoverDirection.top:
        return Offset(0, -widget.offsetDistance / context.size!.height);
      case HoverDirection.bottom:
        return Offset(0, widget.offsetDistance / context.size!.height);
      case HoverDirection.center:
      default:
        return Offset.zero;
    }
  }

  HoverDirection _getEnterDirection(Offset localPosition, Size size) {
    final x = localPosition.dx;
    final y = localPosition.dy;
    final w = size.width;
    final h = size.height;

    if (x < w * 0.25) return HoverDirection.left;
    if (x > w * 0.75) return HoverDirection.right;
    if (y < h * 0.25) return HoverDirection.top;
    if (y > h * 0.75) return HoverDirection.bottom;
    return HoverDirection.center;
  }

  void _handleEnter(PointerEvent event) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;
    final localPos = renderBox.globalToLocal(event.position);
    final dir = _getEnterDirection(localPos, size);
    setState(() {
      _enterDirection = dir;
    });

    _animation = Tween<Offset>(
      begin: _directionToOffset(dir),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(from: 0);
  }

  void _handleExit(PointerEvent event) {
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: _directionToOffset(_enterDirection),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _handleEnter,
      onExit: _handleExit,
      child: SlideTransition(position: _animation, child: widget.child),
    );
  }
}
