import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const NeumorphicContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.color = const Color(0xFFEFF2F9),
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // 밝은 그림자 (왼쪽 위)
          const BoxShadow(
            color: Color(0xFFFAFBFF),
            offset: Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 0,
          ),
          // 어두운 그림자 (오른쪽 아래)
          BoxShadow(
            color: const Color(0x3B161B1D), // 23% opacity
            offset: const Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
