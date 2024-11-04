import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:flash_cards_1/features/common/components/buttons/simple_button.dart';
import 'package:flash_cards_1/features/common/services/cuid.service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddCardItemPage extends StatefulHookConsumerWidget {
  final Function(CardItem) onSave;
  final CardItem? cardItem;

  const AddCardItemPage({
    super.key,
    required this.onSave,
    this.cardItem,
  });

  @override
  AddCardItemPageState createState() => AddCardItemPageState();
}

class AddCardItemPageState extends ConsumerState<AddCardItemPage> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.cardItem?.question ?? '';
    _answerController.text = widget.cardItem?.answer ?? '';
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _saveCard() {
    final question = _questionController.text.trim();
    final answer = _answerController.text.trim();

    if (question.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both question and answer.')),
      );
      return;
    }

    final newCardItem = CardItem(
      id: ref.read(cuidServiceProvider).newCuid(), // Generate a unique ID
      question: question,
      answer: answer,
    );

    widget.onSave(newCardItem); // Trigger the callback with the new CardItem

    // Clear input fields
    _questionController.clear();
    _answerController.clear();

    // Close the form or show success message (optional)
    Navigator.pop(context); // Close dialog/screen if needed
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardItem == null ? 'Add new card' : 'Edit card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                SimpleButton(
                  onPressed: _saveCard,
                  label: widget.cardItem == null ? 'Add' : 'Save Edit',
                  icon: Icons.edit,
                ),
                const SizedBox(
                  width: 16,
                ),
                SimpleButton(
                  onPressed: _cancel,
                  label: 'Cancel',
                  icon: Icons.cancel_outlined,
                  isPrimary: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
