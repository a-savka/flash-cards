import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:flash_cards_1/features/common/services/cuid.service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddCardCategoryPage extends StatefulHookConsumerWidget {
  final Function(CardCategory) onCategoryCreated;

  const AddCardCategoryPage({
    super.key,
    required this.onCategoryCreated,
  });

  @override
  AddCardCategoryPageState createState() => AddCardCategoryPageState();
}

class AddCardCategoryPageState extends ConsumerState<AddCardCategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  String? _filePath;
  final List<CardItem> _cardItems = [];

  Future<void> _pickFileAndParse() async {
    // Open file picker dialog to select a text file
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
    if (result != null && result.files.single.path != null) {
      _filePath = result.files.single.path;
      await _parseFile();
    }
  }

  Future<void> _parseFile() async {
    if (_filePath == null) return;

    final file = File(_filePath!);
    final lines = await file.readAsLines();

    // Clear any existing items before parsing
    _cardItems.clear();

    for (var line in lines) {
      final parts = line.split('|');
      if (parts.length == 2) {
        final question = parts[0].trim();
        final answer = parts[1].trim();
        final cardItem = CardItem(
          id: ref.read(cuidServiceProvider).newCuid(),
          question: question,
          answer: answer,
        );
        _cardItems.add(cardItem);
      }
    }

    // Notify user if no valid items were found
    if (_cardItems.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No valid card items found in the file.')),
        );
      }
    }
  }

  void _createCardCategory() {
    final categoryName = _nameController.text.trim();
    if (categoryName.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a category name.')),
        );
      }
      return;
    }

    if (_cardItems.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'No card items have been added. Please select a valid file.')),
        );
      }
      return;
    }

    // Create the CardCategory instance and pass it back via callback
    final cardCategory = CardCategory(
      id: ref.read(cuidServiceProvider).newCuid(),
      name: categoryName,
      items: _cardItems,
    );
    widget.onCategoryCreated(cardCategory);

    Navigator.pop(context); // Go back to previous screen
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickFileAndParse,
              child: const Text('Continue'),
            ),
            if (_filePath != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Selected File: ${_filePath!.split('/').last}',
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _createCardCategory,
              child: const Text('Create Category'),
            ),
          ],
        ),
      ),
    );
  }
}
