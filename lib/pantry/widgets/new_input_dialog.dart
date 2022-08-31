import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';

class NewInputDialog extends ConsumerStatefulWidget {
  const NewInputDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<NewInputDialog> createState() => _NewInputDialogState();
}

class _NewInputDialogState extends ConsumerState<NewInputDialog> {
  String foodName = "";
  double quantity = 0.0;
  String unit = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter new food name"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              onChanged: (newValue) {
                foodName = newValue;
              },
              decoration: const InputDecoration(hintText: "name"),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (newQuantity) {
                quantity = double.parse(newQuantity);
              },
              decoration: const InputDecoration(hintText: "quantity"),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (newUnit) {
                unit = newUnit;
              },
              decoration: const InputDecoration(hintText: "unit"),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            FoodItemCreate()
              ..name = foodName
              ..quantity = quantity
              ..unit = unit,
          ),
          child: const Text("Add Food"),
        )
      ],
    );
  }
}
