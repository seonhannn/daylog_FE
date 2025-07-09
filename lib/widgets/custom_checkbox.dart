import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final double size;
  final Color activeColor;
  final Color borderColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 20,
    this.activeColor = const Color(0xFF4A90E2),
    this.borderColor = const Color(0xFFB0B3B8),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged!(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: value ? activeColor : borderColor, width: 1.5),
        ),
        child: value ? Icon(Icons.check, size: size * 0.7, color: Colors.white) : null,
      ),
    );
  }
}
