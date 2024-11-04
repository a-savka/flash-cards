import 'package:flutter/material.dart';

enum SimpleButtonType { success, danger, regular }

class SimpleButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final IconData icon;
  final SimpleButtonType buttonType;

  const SimpleButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.buttonType = SimpleButtonType.regular,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    Color fgColor = Colors.grey[700]!;

    if (buttonType == SimpleButtonType.success) {
      bgColor = Colors.green[600]!;
      fgColor = Colors.white;
    } else if (buttonType == SimpleButtonType.danger) {
      bgColor = Colors.red[700]!;
      fgColor = Colors.white;
    }

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
