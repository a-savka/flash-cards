import 'dart:convert';
import 'package:flash_cards_1/features/card_categories/models/card_category.dart';

CardCategory getWeatherCategoryMock() {
  // Mock JSON data representing a "Weather" category with 25 items
  const String jsonData = '''
  {
    "id": "1",
    "name": "Weather",
    "items": [
      { "id": "1", "question": "sun", "answer": "солнце" },
      { "id": "2", "question": "rain", "answer": "дождь" },
      { "id": "3", "question": "snow", "answer": "снег" },
      { "id": "4", "question": "wind", "answer": "ветер" },
      { "id": "5", "question": "storm", "answer": "буря" },
      { "id": "6", "question": "cloud", "answer": "облако" },
      { "id": "7", "question": "fog", "answer": "туман" },
      { "id": "8", "question": "lightning", "answer": "молния" },
      { "id": "9", "question": "thunder", "answer": "гром" },
      { "id": "10", "question": "temperature", "answer": "температура" },
      { "id": "11", "question": "humidity", "answer": "влажность" },
      { "id": "12", "question": "drizzle", "answer": "морось" },
      { "id": "13", "question": "hail", "answer": "град" },
      { "id": "14", "question": "breeze", "answer": "бриз" },
      { "id": "15", "question": "heat", "answer": "жара" },
      { "id": "16", "question": "cold", "answer": "холод" },
      { "id": "17", "question": "dew", "answer": "роса" },
      { "id": "18", "question": "frost", "answer": "иней" },
      { "id": "19", "question": "freezing", "answer": "заморозки" },
      { "id": "20", "question": "forecast", "answer": "прогноз" },
      { "id": "21", "question": "ice", "answer": "лед" },
      { "id": "22", "question": "sunshine", "answer": "солнечный свет" },
      { "id": "23", "question": "overcast", "answer": "пасмурно" },
      { "id": "24", "question": "mist", "answer": "дымка" },
      { "id": "25", "question": "blizzard", "answer": "метель" }
    ]
  }
  ''';

  final Map<String, dynamic> categoryData = jsonDecode(jsonData);
  final CardCategory weatherCategory = CardCategory.fromJson(categoryData);

  return weatherCategory;
}
