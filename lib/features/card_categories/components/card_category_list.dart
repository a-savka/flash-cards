import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_categories/pages/category_cards_page.dart';
import 'package:flutter/material.dart';

class CardCategoryList extends StatelessWidget {
  final List<CardCategory> categories;

  const CardCategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final category = categories[index];

              return ListTile(
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
              );
            },
            childCount: categories.length,
          ),
        ),
      ],
    );
  }
}
