import 'dart:convert';

import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_categories/pages/card_category_list_page.dart';
import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:flash_cards_1/initial_components.dart';
import 'package:flash_cards_1/main.data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_theme_plus/json_theme_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(CardItemAdapter());
  Hive.registerAdapter(CardCategoryAdapter());

  final themeStr = await rootBundle.loadString('assets/theme/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(ProviderScope(
    overrides: [configureRepositoryLocalStorage()],
    child: MyAppShell(theme: theme),
  ));
}

class MyAppShell extends HookConsumerWidget {
  final ThemeData theme;
  const MyAppShell({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(repositoryInitializerProvider).when(
          data: (_) {
            return MyApp(theme: theme);
          },
          error: (e, __) {
            return const AppLoadingError();
          },
          loading: () => const AppLoading(),
        );
  }
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Cards',
      theme: theme.copyWith(
        appBarTheme: AppBarTheme(
          color: theme.primaryColor,
          actionsIconTheme: const IconThemeData(color: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      // theme: ThemeData(
      //   primaryColor: Colors.blue,
      //   // colorScheme: ColorScheme(primary: Colors.blue),
      //   appBarTheme: AppBarTheme(
      //     color: Colors.blue[700],
      //     titleTextStyle: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
      home: const CardCategoryListPage(),
    );
  }
}
