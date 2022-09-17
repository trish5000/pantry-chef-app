import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';

typedef UpdateRecipe = void Function(
    int index, IngredientCreate ingredientCreate);

class IngredientFields extends ConsumerStatefulWidget {
  final int index;
  final UpdateRecipe? updateRecipe;
  const IngredientFields(
      {Key? key, required this.index, required this.updateRecipe})
      : super(key: key);

  @override
  ConsumerState<IngredientFields> createState() => _IngredientFieldsState();
}

class _IngredientFieldsState extends ConsumerState<IngredientFields> {
  late TextEditingController nameController, quantityController, unitController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController()
      ..addListener(() {
        updateRecipe();
      });
    quantityController = TextEditingController()
      ..addListener(() {
        updateRecipe();
      });
    unitController = TextEditingController()
      ..addListener(() {
        updateRecipe();
      });
  }

  void updateRecipe() {
    if (quantityController.text.isEmpty) return;

    final ingredientCreate = IngredientCreate()
      ..name = nameController.text
      ..quantity = double.parse(quantityController.text)
      ..unit = unitController.text;
    widget.updateRecipe!(widget.index, ingredientCreate);
  }

  Widget ingredientFields() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicWidth(
          child: TextField(
            controller: quantityController,
            decoration: const InputDecoration(hintText: "amount"),
          ),
        ),
        const SizedBox(width: 8),
        IntrinsicWidth(
          child: TextField(
            controller: unitController,
            decoration: const InputDecoration(hintText: "unit"),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "ingredient"),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ingredientFields();
  }
}
