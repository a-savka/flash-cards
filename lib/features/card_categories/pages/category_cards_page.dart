import 'package:flash_cards_1/features/card_categories/components/catgeory_flash_cards.dart';
import 'package:flash_cards_1/features/card_categories/providers/reverse_mode.provider.dart';
import 'package:flash_cards_1/main.data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryCardsPage extends HookConsumerWidget {
  final String categoryId;
  final String categoryName;

  const CategoryCardsPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reverseMode = ref.watch(reverseModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          Switch(
            value: reverseMode,
            onChanged: (value) {
              ref.read(reverseModeProvider.notifier).state = value;
            },
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        final state = ref.cardCategories.watchOne(categoryId);

        if (state.isLoading || !state.hasModel || state.model == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final category = state.model!;
        return CategoryFlashCards(cardCategory: category);
      }),
    );
  }
}
