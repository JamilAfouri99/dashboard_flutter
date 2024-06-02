import 'package:flutter/material.dart';

class AnimatedPlaceholder extends StatefulWidget {
  final double width;
  final double height;

  const AnimatedPlaceholder({super.key, required this.width, required this.height});

  @override
  _AnimatedPlaceholderState createState() => _AnimatedPlaceholderState();
}

class _AnimatedPlaceholderState extends State<AnimatedPlaceholder>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FadeTransition(
      opacity: _animation,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
