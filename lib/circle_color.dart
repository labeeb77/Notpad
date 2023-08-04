import 'package:flutter/material.dart';

class CircleColor extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const CircleColor({super.key, 
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
      ),
    );
  }
}