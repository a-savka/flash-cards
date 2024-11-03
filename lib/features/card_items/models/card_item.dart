import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_data/flutter_data.dart';

part 'card_item.g.dart';

@HiveType(typeId: 0) // Define a unique type ID for Hive storage
@JsonSerializable() // This annotation is for JSON serialization
@DataRepository([]) // This annotation is for flutter_data
class CardItem extends DataModel<CardItem> {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final String answer;

  CardItem({
    required this.id,
    required this.question,
    required this.answer,
  });

  // A factory constructor to create a CardItem instance from JSON
  factory CardItem.fromJson(Map<String, dynamic> json) =>
      _$CardItemFromJson(json);

  // A method to convert a CardItem instance to JSON
  Map<String, dynamic> toJson() => _$CardItemToJson(this);

  CardItem copyWith({
    String? id,
    String? question,
    String? answer,
  }) {
    return CardItem(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}
