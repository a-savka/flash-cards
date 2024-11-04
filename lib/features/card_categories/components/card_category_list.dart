import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_categories/pages/category_cards_page.dart';
import 'package:flash_cards_1/features/card_categories/pages/edit_category_name_page.dart';
import 'package:flash_cards_1/features/common/components/generic/bottom_sheet_confirmation.dart';
import 'package:flash_cards_1/features/common/services/filesystem.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class CardCategoryList extends StatefulHookConsumerWidget {
  final List<CardCategory> categories;
  final void Function(CardCategory category) onDelete;

  const CardCategoryList({
    super.key,
    required this.categories,
    required this.onDelete,
  });

  @override
  CardCategoryListState createState() => CardCategoryListState();
}

class CardCategoryListState extends ConsumerState<CardCategoryList> {
  void _onDelete(CardCategory category) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return const BottomSheetConfirmation(
          message: 'Are you sure you want to delete this category?',
          yesLabel: 'Delete',
          noLabel: 'Cancel',
        );
      },
    );

    if (confirmed == true) {
      widget.onDelete(category);
    }
  }

  void _onEdit(CardCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCategoryNamePage(
          category: category,
          onSave: (String newName) {
            final updatedCategory = category.copyWith(name: newName);
            updatedCategory.saveLocal();
          },
        ),
      ),
    );
  }

  void _onExport(
    CardCategory category,
  ) async {
    final FileSystemService fileSystem = ref.read(fileSystemServiceProvider);

    String? path = await fileSystem.pickDirectoryPath();
    bool fileSaved = false;

    if (path != null && mounted) {
      String? fileName =
          await fileSystem.requestFileName(context, category.name);
      if (fileName != null) {
        path = '$path/$fileName';
        final fileExists = await File(path).exists();
        if (context.mounted) {
          final operationConfirmed =
              await fileSystem.confirmFileOverwrite(fileExists, context);
          if (operationConfirmed) {
            final lines = category.items
                .map((card) => '${card.question}|${card.answer}')
                .toList();

            final exportContent = lines.join('\n');

            await fileSystem.writeTextFile(path, exportContent);
            fileSaved = true;
          }
        }
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            fileSaved
                ? 'File was successfully saved'
                : 'Failed to save the file',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final category = widget.categories[index];

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
                      onPressed: (context) => _onDelete(category),
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
            childCount: widget.categories.length,
          ),
        ),
      ],
    );
  }
}
