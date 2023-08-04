
import 'package:flutter/material.dart';

class IconButtonWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const IconButtonWithText({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}
