import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_categories/pages/category_cards_page.dart';
import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardCategoryList extends StatelessWidget {
  final List<CardCategory> categories;
  final void Function(CardCategory category) onDelete;

  const CardCategoryList({
    super.key,
    required this.categories,
    required this.onDelete,
  });

  void _onDelete(BuildContext context, CardCategory category) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Confirm deletion
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Cancel deletion
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (confirmed == true) {
      onDelete(category);
    }
  }

  void _onEdit(CardCategory category) {}

  void _onExport(CardCategory category) {}

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final category = categories[index];

              return Slidable(
                key: ValueKey(category.id),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => _onEdit(category),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.blue,
                      icon: Icons.edit,
                    ),
                    SlidableAction(
                      onPressed: (context) => _onExport(category),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.green,
                      icon: Icons.file_download,
                    ),
                    SlidableAction(
                      onPressed: (context) => _onDelete(context, category),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.red,
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryCardsPage(
                          categoryId: category.id,
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            childCount: categories.length,
          ),
        ),
      ],
    );
  }
}
