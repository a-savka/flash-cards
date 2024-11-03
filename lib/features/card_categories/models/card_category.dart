import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_data/flutter_data.dart';

part 'card_category.g.dart';

@HiveType(typeId: 1) // Define a unique type ID for Hive storage
@JsonSerializable() // This annotation is for JSON serialization
@DataRepository([]) // This annotation is for flutter_data
class CardCategory extends DataModel<CardCategory> {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<CardItem> items;

  CardCategory({
    required this.id,
    required this.name,
    required this.items,
  });

  // A factory constructor to create a CardCategory instance from JSON
  factory CardCategory.fromJson(Map<String, dynamic> json) =>
      _$CardCategoryFromJson(json);

  // A method to convert a CardCategory instance to JSON
  Map<String, dynamic> toJson() => _$CardCategoryToJson(this);

  // CopyWith method for CardCategory
  CardCategory copyWith({
    String? id,
    String? name,
    List<CardItem>? items,
  }) {
    return CardCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}
