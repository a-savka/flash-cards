// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_category.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $CardCategoryLocalAdapter on LocalAdapter<CardCategory> {
  static final Map<String, RelationshipMeta> _kCardCategoryRelationshipMetas =
      {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kCardCategoryRelationshipMetas;

  @override
  CardCategory deserialize(map) {
    map = transformDeserialize(map);
    return CardCategory.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _cardCategoriesFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $CardCategoryHiveLocalAdapter = HiveLocalAdapter<CardCategory>
    with $CardCategoryLocalAdapter;

class $CardCategoryRemoteAdapter = RemoteAdapter<CardCategory>
    with NothingMixin;

final internalCardCategoriesRemoteAdapterProvider =
    Provider<RemoteAdapter<CardCategory>>((ref) => $CardCategoryRemoteAdapter(
        $CardCategoryHiveLocalAdapter(ref),
        InternalHolder(_cardCategoriesFinders)));

final cardCategoriesRepositoryProvider =
    Provider<Repository<CardCategory>>((ref) => Repository<CardCategory>(ref));

extension CardCategoryDataRepositoryX on Repository<CardCategory> {}

extension CardCategoryRelationshipGraphNodeX
    on RelationshipGraphNode<CardCategory> {}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardCategoryAdapter extends TypeAdapter<CardCategory> {
  @override
  final int typeId = 1;

  @override
  CardCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardCategory(
      id: fields[0] as String,
      name: fields[1] as String,
      items: (fields[2] as List).cast<CardItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, CardCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardCategory _$CardCategoryFromJson(Map<String, dynamic> json) => CardCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardCategoryToJson(CardCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items,
    };
