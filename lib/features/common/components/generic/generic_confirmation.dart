import 'package:flutter/material.dart';

class GenericConfirmation extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onReject;
  const GenericConfirmation({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const ColoredBox(
                color: Colors.grey,
                child: SizedBox(
                  height: 4,
                  width: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 30, 70, 15),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                message,
                style: const TextStyle(
                    color: Color(0xFF666666), fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: onReject,
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
