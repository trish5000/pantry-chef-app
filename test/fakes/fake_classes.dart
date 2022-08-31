import 'package:faker/faker.dart';
import 'package:pantry_chef_app/pantry/models/food_item.dart';

final _faker = Faker();
FoodItem get fakeFoodItem => FoodItem()
  ..name = _faker.lorem.word()
  ..quantity = _faker.randomGenerator.decimal()
  ..unit = _faker.lorem.word();

List<FoodItem> fakePantry() {
  final foodItemCount = _faker.randomGenerator.integer(300);
  final pantry =
      List<FoodItem>.generate(foodItemCount, (index) => fakeFoodItem);

  return pantry;
}
