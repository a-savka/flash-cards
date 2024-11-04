import 'package:flash_cards_1/features/common/components/buttons/simple_button.dart';
import 'package:flutter/material.dart';

class BottomSheetConfirmation extends StatelessWidget {
  final String message;
  final String yesLabel;
  final String noLabel;

  const BottomSheetConfirmation({
    super.key,
    required this.message,
    this.yesLabel = 'Yes',
    this.noLabel = 'No',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Are you sure you want to delete this category?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                label: yesLabel,
                icon: Icons.delete,
                buttonType: SimpleButtonType.danger,
              ),
              SimpleButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                label: noLabel,
                icon: Icons.cancel_outlined,
                buttonType: SimpleButtonType.regular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
