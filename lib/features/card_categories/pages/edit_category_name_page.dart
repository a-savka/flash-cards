import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/common/components/buttons/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditCategoryNamePage extends StatefulHookConsumerWidget {
  final Function(String) onSave;
  final CardCategory category;

  const EditCategoryNamePage({
    super.key,
    required this.onSave,
    required this.category,
  });

  @override
  EditCategoryNamePageState createState() => EditCategoryNamePageState();
}

class EditCategoryNamePageState extends ConsumerState<EditCategoryNamePage> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.category.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter category name.')),
      );
      return;
    }

    widget.onSave(name);
    _nameController.clear();
    Navigator.pop(context); // Close dialog/screen if needed
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                SimpleButton(
                  onPressed: _saveCategory,
                  label: 'Save',
                  icon: Icons.edit,
                  buttonType: SimpleButtonType.success,
                ),
                const SizedBox(
                  width: 16,
                ),
                SimpleButton(
                  onPressed: _cancel,
                  label: 'Cancel',
                  icon: Icons.cancel_outlined,
                  buttonType: SimpleButtonType.regular,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
