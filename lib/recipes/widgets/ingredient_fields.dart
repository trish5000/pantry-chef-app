import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';

typedef UpdateIngredient = void Function(int index, IngredientCreate updated);
typedef DeleteIngredient = void Function(int index);

class IngredientFields extends ConsumerStatefulWidget {
  final int index;
  final IngredientCreate ingredient;
  final UpdateIngredient? updateIngredient;
  final DeleteIngredient? deleteIngredient;
  const IngredientFields({
    Key? key,
    required this.index,
    required this.ingredient,
    required this.updateIngredient,
    required this.deleteIngredient,
  }) : super(key: key);

  @override
  ConsumerState<IngredientFields> createState() => _IngredientFieldsState();
}

class _IngredientFieldsState extends ConsumerState<IngredientFields> {
  late TextEditingController nameController, quantityController, unitController;

  @override
  void initState() {
    super.initState();

    final initialName = widget.ingredient.name;
    nameController =
        TextEditingController(text: initialName.isEmpty ? null : initialName)
          ..addListener(() {
            updateIngredient();
          });

    final initialQuantity = widget.ingredient.quantity;
    quantityController = TextEditingController(
        text: initialQuantity == 0 ? null : initialQuantity.toString())
      ..addListener(() {
        updateIngredient();
      });

    final initialUnit = widget.ingredient.unit;
    unitController =
        TextEditingController(text: initialUnit.isEmpty ? null : initialUnit)
          ..addListener(() {
            updateIngredient();
          });
  }

  void updateIngredient() {
    if (quantityController.text.isEmpty) return;

    final newIngredient = IngredientCreate()
      ..name = nameController.text
      ..quantity = double.parse(quantityController.text)
      ..unit = unitController.text;
    widget.updateIngredient!(widget.index, newIngredient);
  }

  Widget ingredientFields() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicWidth(
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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

  Widget deleteIngredientButton() {
    return SizedBox(
      width: 32,
      child: Center(
        child: TextButton(
          onPressed: () {
            widget.deleteIngredient!(widget.index);
          },
          child: const Icon(Icons.close, size: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ingredientFields(),
      Positioned(
        top: 10,
        right: 2,
        child: deleteIngredientButton(),
      ),
    ]);
  }
}
