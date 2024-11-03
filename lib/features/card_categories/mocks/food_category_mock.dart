import 'dart:convert';
import 'package:flash_cards_1/features/card_categories/models/card_category.dart';

CardCategory getFoodCategoryMock() {
  // Mock JSON data representing a "Weather" category with 25 items
  const jsonData = '''
  {
    "id": "11",
    "name": "Food",
    "items": [
      {"id": "11", "question": "apple", "answer": "яблоко"},
      {"id": "12", "question": "bread", "answer": "хлеб"},
      {"id": "13", "question": "milk", "answer": "молоко"},
      {"id": "14", "question": "cheese", "answer": "сыр"},
      {"id": "15", "question": "butter", "answer": "масло"},
      {"id": "16", "question": "egg", "answer": "яйцо"},
      {"id": "17", "question": "meat", "answer": "мясо"},
      {"id": "18", "question": "fish", "answer": "рыба"},
      {"id": "19", "question": "potato", "answer": "картофель"},
      {"id": "110", "question": "carrot", "answer": "морковь"},
      {"id": "111", "question": "tomato", "answer": "помидор"},
      {"id": "112", "question": "onion", "answer": "лук"},
      {"id": "113", "question": "garlic", "answer": "чеснок"},
      {"id": "114", "question": "cucumber", "answer": "огурец"},
      {"id": "115", "question": "banana", "answer": "банан"},
      {"id": "116", "question": "grape", "answer": "виноград"},
      {"id": "117", "question": "orange", "answer": "апельсин"},
      {"id": "118", "question": "strawberry", "answer": "клубника"},
      {"id": "119", "question": "watermelon", "answer": "арбуз"},
      {"id": "120", "question": "chicken", "answer": "курица"},
      {"id": "121", "question": "rice", "answer": "рис"},
      {"id": "122", "question": "pasta", "answer": "макароны"},
      {"id": "123", "question": "cake", "answer": "торт"},
      {"id": "124", "question": "soup", "answer": "суп"},
      {"id": "125", "question": "salad", "answer": "салат"}
    ]
  }
  ''';

  final Map<String, dynamic> categoryData = jsonDecode(jsonData);
  final CardCategory foodCategory = CardCategory.fromJson(categoryData);

  return foodCategory;
}
