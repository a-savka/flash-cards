import 'package:flash_cards_1/features/card_categories/components/card_category_list.dart';
import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/main.data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CardCategoryListCardsWrapper extends HookConsumerWidget {
  const CardCategoryListCardsWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.cardCategories.watchAll();

    if (categories.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!categories.hasModel || categories.model.isEmpty) {
      return const Center(
        child: Text('No categories available '),
      );
    }

    return CardCategoryList(
      categories: categories.model,
      onDelete: (cardCategory) {
        ref
            .read(cardCategoriesRepositoryProvider)
            .delete(cardCategory.id, remote: false);
      },
    );
  }
}
