import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final IconData icon;
  final bool isPrimary;

  const SimpleButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isPrimary ? Colors.green[600] : Colors.white;
    final fgColor = isPrimary ? Colors.white : Colors.grey[700];

    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      icon: Icon(
        icon,
        size: 16,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        iconColor: fgColor,
        foregroundColor: fgColor,
        padding: const EdgeInsets.all(20),
        elevation: 4,
      ),
    );
  }
}
