// import 'package:flash_cards_1/features/card_categories/mocks/food_category_mock.dart';
// import 'package:flash_cards_1/features/card_categories/mocks/weather_category_mock.dart';
import 'dart:convert';

import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_categories/pages/card_category_list_page.dart';
import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:flash_cards_1/initial_components.dart';
import 'package:flash_cards_1/main.data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_data/flutter_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(CardItemAdapter());
  Hive.registerAdapter(CardCategoryAdapter());

  // final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  // final themeJson = jsonDecode(themeStr);
  // final theme = ThemeDeco.decodeThemeData(themeJson)!;

  runApp(ProviderScope(
    overrides: [configureRepositoryLocalStorage()],
    child: const MyAppShell(),
  ));
}

class MyAppShell extends HookConsumerWidget {
  const MyAppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(repositoryInitializerProvider).when(
          data: (_) {
            return const MyApp();
          },
          error: (e, __) {
            return const AppLoadingError();
          },
          loading: () => const AppLoading(),
        );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final CardCategory weatherCategory = getWeatherCategoryMock();
    // final CardCategory foodCategory = getFoodCategoryMock();

    // weatherCategory.saveLocal();
    // foodCategory.saveLocal();

    return MaterialApp(
      title: 'Flash Cards',
      theme: ThemeData(
        primaryColor: Colors.blue,
        // colorScheme: ColorScheme(primary: Colors.blue),
        appBarTheme: AppBarTheme(
          color: Colors.blue[700],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      home: const CardCategoryListPage(),
    );
  }
}
