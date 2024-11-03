import 'package:flash_cards_1/features/card_categories/components/card_actions.dart';
import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_items/components/flash_card.dart';
import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:flash_cards_1/features/card_items/pages/add_card_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryFlashCards extends StatefulHookConsumerWidget {
  final CardCategory cardCategory;

  const CategoryFlashCards({super.key, required this.cardCategory});

  @override
  CategoryFlashCardsState createState() => CategoryFlashCardsState();
}

class CategoryFlashCardsState extends ConsumerState<CategoryFlashCards> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _addNewCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardItemPage(
          onSave: (CardItem cardItem) {
            final updatedCategory = widget.cardCategory.copyWith(items: [
              ...widget.cardCategory.items,
              cardItem,
            ]);
            cardItem.saveLocal();
            updatedCategory.saveLocal();
          },
        ),
      ),
    );
  }

  void _editCard() {
    CardItem editingItem = widget.cardCategory.items[_currentIndex];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardItemPage(
          cardItem: editingItem,
          onSave: (CardItem cardItem) {
            final updatedCategory = widget.cardCategory.copyWith(
                items: widget.cardCategory.items.map((it) {
              if (it.id == editingItem.id) {
                final updated = it.copyWith(
                  question: cardItem.question,
                  answer: cardItem.answer,
                );
                updated.saveLocal();
                return updated;
              }
              return it;
            }).toList());
            updatedCategory.saveLocal();
          },
        ),
      ),
    );
  }

  void _deleteCard() async {
    final cardToDelete = widget.cardCategory.items[_currentIndex];
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to delete this card?',
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
      final updatedCategory = widget.cardCategory.copyWith(
        items: widget.cardCategory.items
            .where((it) => it.id != cardToDelete.id)
            .toList(),
      );
      updatedCategory.saveLocal();
      if (_currentIndex >= updatedCategory.items.length) {
        _currentIndex = updatedCategory.items.length - 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // PageView for swiping between FlashCards
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.cardCategory.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final cardItem = widget.cardCategory.items[index];
              return Center(
                child: FlashCard(cardItem: cardItem),
              );
            },
          ),
        ),

        // Navigation indicators
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10.0,
            children: List.generate(
              widget.cardCategory.items.length,
              (index) => GestureDetector(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _currentIndex == index ? 20.0 : 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.blueAccent
                        : Theme.of(context)
                            .colorScheme
                            .inversePrimary
                            .withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                },
              ),
            ),
          ),
        ),

        CardActions(
          canEdit: true,
          onAdd: _addNewCard,
          onEdit: _editCard,
          onDelete: _deleteCard,
        ),
      ],
    );
  }
}
