import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBubbleWithTail extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double tailSize;
  final Color color;
  final double opacity;
  final Gradient? gradient;

  const GlassBubbleWithTail({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.tailSize = 16,
    this.color = Colors.white,
    this.opacity = 0.4,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffe3e5e8).withOpacity(0.6),
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white),
          ),
          padding: EdgeInsets.fromLTRB(16, 16, tailSize + 8, 16),
          child: child,
        ),
      ),
    );
  }
}
