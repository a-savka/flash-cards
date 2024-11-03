

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block, depend_on_referenced_packages

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flash_cards_1/features/card_categories/models/card_category.dart';
import 'package:flash_cards_1/features/card_items/models/card_item.dart';

// ignore: prefer_function_declarations_over_variables
ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String>? baseDirFn, List<int>? encryptionKey, LocalStorageClearStrategy? clear}) {
  if (!kIsWeb) {
    baseDirFn ??= () => getApplicationDocumentsDirectory().then((dir) => dir.path);
  } else {
    baseDirFn ??= () => '';
  }
  
  return hiveLocalStorageProvider.overrideWith(
    (ref) => HiveLocalStorage(
      hive: ref.read(hiveProvider),
      baseDirFn: baseDirFn,
      encryptionKey: encryptionKey,
      clear: clear,
    ),
  );
};

final repositoryProviders = <String, Provider<Repository<DataModelMixin>>>{
  'cardCategories': cardCategoriesRepositoryProvider,
'cardItems': cardItemsRepositoryProvider
};

final repositoryInitializerProvider =
  FutureProvider<RepositoryInitializer>((ref) async {
    DataHelpers.setInternalType<CardCategory>('cardCategories');
    DataHelpers.setInternalType<CardItem>('cardItems');
    final adapters = <String, RemoteAdapter>{'cardCategories': ref.watch(internalCardCategoriesRemoteAdapterProvider), 'cardItems': ref.watch(internalCardItemsRemoteAdapterProvider)};
    final remotes = <String, bool>{'cardCategories': true, 'cardItems': true};

    await ref.watch(graphNotifierProvider).initialize();

    // initialize and register
    for (final type in repositoryProviders.keys) {
      final repository = ref.read(repositoryProviders[type]!);
      repository.dispose();
      await repository.initialize(
        remote: remotes[type],
        adapters: adapters,
      );
      internalRepositories[type] = repository;
    }

    return RepositoryInitializer();
});
extension RepositoryWidgetRefX on WidgetRef {
  Repository<CardCategory> get cardCategories => watch(cardCategoriesRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<CardItem> get cardItems => watch(cardItemsRepositoryProvider)..remoteAdapter.internalWatch = watch;
}

extension RepositoryRefX on Ref {

  Repository<CardCategory> get cardCategories => watch(cardCategoriesRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<CardItem> get cardItems => watch(cardItemsRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
}