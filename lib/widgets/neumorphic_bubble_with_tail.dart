import 'package:flutter/material.dart';

class NeumorphicBubbleWithTail extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double tailSize;

  const NeumorphicBubbleWithTail({
    super.key,
    required this.child,
    this.color = const Color(0xFFEFF2F9),
    this.borderRadius = 20,
    this.tailSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 본체(뉴모피즘)
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              const BoxShadow(color: Color(0xFFFAFBFF), offset: Offset(-5, -5), blurRadius: 10),
              BoxShadow(color: const Color(0x3B161B1D), offset: const Offset(5, 5), blurRadius: 10),
            ],
          ),
          padding: EdgeInsets.fromLTRB(16, 16, tailSize + 8, 16),
          child: child,
        ),
        // 꼬리
        Positioned(
          right: -tailSize + 2,
          bottom: 12,
          child: CustomPaint(
            painter: _NeumorphicTailPainter(color: color),
            size: Size(tailSize, tailSize),
          ),
        ),
      ],
    );
  }
}

class _NeumorphicTailPainter extends CustomPainter {
  final Color color;
  _NeumorphicTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.5, size.width, size.height);
    path.lineTo(size.width * 0.5, size.height * 0.7);
    path.close();

    // 그림자
    canvas.drawShadow(path, const Color(0x3B161B1D), 4, false);
    // 꼬리 본체
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
