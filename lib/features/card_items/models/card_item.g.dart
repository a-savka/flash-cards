// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_item.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $CardItemLocalAdapter on LocalAdapter<CardItem> {
  static final Map<String, RelationshipMeta> _kCardItemRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kCardItemRelationshipMetas;

  @override
  CardItem deserialize(map) {
    map = transformDeserialize(map);
    return CardItem.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _cardItemsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $CardItemHiveLocalAdapter = HiveLocalAdapter<CardItem>
    with $CardItemLocalAdapter;

class $CardItemRemoteAdapter = RemoteAdapter<CardItem> with NothingMixin;

final internalCardItemsRemoteAdapterProvider =
    Provider<RemoteAdapter<CardItem>>((ref) => $CardItemRemoteAdapter(
        $CardItemHiveLocalAdapter(ref), InternalHolder(_cardItemsFinders)));

final cardItemsRepositoryProvider =
    Provider<Repository<CardItem>>((ref) => Repository<CardItem>(ref));

extension CardItemDataRepositoryX on Repository<CardItem> {}

extension CardItemRelationshipGraphNodeX on RelationshipGraphNode<CardItem> {}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardItemAdapter extends TypeAdapter<CardItem> {
  @override
  final int typeId = 0;

  @override
  CardItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardItem(
      id: fields[0] as String,
      question: fields[1] as String,
      answer: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardItem _$CardItemFromJson(Map<String, dynamic> json) => CardItem(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$CardItemToJson(CardItem instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
