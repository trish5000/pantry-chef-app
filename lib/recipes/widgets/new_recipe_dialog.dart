import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/recipes/models/recipe_create.dart';
import 'package:pantry_chef_app/recipes/widgets/ingredient_fields.dart';

class NewRecipeDialog extends ConsumerStatefulWidget {
  const NewRecipeDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<NewRecipeDialog> createState() => _NewRecipeDialogState();
}

class _NewRecipeDialogState extends ConsumerState<NewRecipeDialog> {
  late TextEditingController nameController,
      procedureController,
      servingsController;
  List<IngredientCreate> ingredients = [];
  List<UniqueKey> ingredientKeys = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    procedureController = TextEditingController();
    servingsController = TextEditingController();
  }

  void updateIngredient(int index, IngredientCreate updated) {
    setState(() {
      ingredients[index] = updated;
    });
  }

  void deleteIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
      ingredientKeys.removeAt(index);
    });
  }

  Widget heading(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget procedureField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: procedureController,
        maxLines: 10,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.only(top: 12, left: 12, bottom: 12),
        ),
      ),
    );
  }

  Widget addIngredientButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
        onPressed: () {
          setState(() {
            final newIngredient = IngredientCreate();
            ingredients.add(newIngredient);
            ingredientKeys.add(UniqueKey());
          });
        },
        child: Row(
          children: const [
            Icon(Icons.add, size: 18),
            Text("Add Ingredient"),
          ],
        ),
      ),
    );
  }

  Widget ingredientList() {
    return Flexible(
      child: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) => IngredientFields(
          key: ingredientKeys[index],
          index: index,
          ingredient: ingredients[index],
          updateIngredient: updateIngredient,
          deleteIngredient: deleteIngredient,
        ),
        shrinkWrap: true,
      ),
    );
  }

  Widget servingsField() {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: "1.0",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.only(top: 12, left: 12, bottom: 12),
      ),
      controller: servingsController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter recipe name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 12, left: 12, bottom: 12),
                ),
                controller: nameController,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heading("Servings"),
              servingsField(),
              heading("Ingredients"),
              ingredientList(),
              addIngredientButton(),
              heading("Procedure"),
              procedureField(),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(
                  RecipeCreate()
                    ..name = nameController.text
                    ..servings = double.parse(servingsController.text)
                    ..procedure = procedureController.text
                    ..ingredients = ingredients,
                ),
                child: const Text(
                  "Add Recipe", // TODO add validation and button disabling
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
