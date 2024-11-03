import 'package:flash_cards_1/features/card_categories/components/card_category_list_wrapper.dart';
import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_categories/pages/add_card_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';

class CardCategoryListPage extends StatelessWidget {
  const CardCategoryListPage({
    super.key,
  });

  void _addCategory(CardCategory newCategory) {
    print('New category was added: ${newCategory.name}');
    newCategory.saveLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddCardCategoryPage and wait for a result
          final newCategory = await Navigator.push<CardCategory>(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddCardCategoryPage(onCategoryCreated: _addCategory),
            ),
          );

          // If a new category was created, add it to the list
          if (newCategory != null) {
            _addCategory(newCategory);
          }
        },
        tooltip: 'Add New Category',
        child: const Icon(Icons.add),
      ),
      body: const CardCategoryListCardsWrapper(),
    );
  }
}
