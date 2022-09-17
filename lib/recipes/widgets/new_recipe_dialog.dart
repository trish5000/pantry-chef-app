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
  late TextEditingController nameController, procedureController;
  List<IngredientCreate> ingredients = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    procedureController = TextEditingController();
  }

  void updateIngredient(int index, IngredientCreate ingredientCreate) {
    ingredients[index] = ingredientCreate;
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
            ingredients.add(IngredientCreate());
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

  Widget deleteIngredientButton(int index) {
    return SizedBox(
      width: 32,
      child: Center(
        child: TextButton(
          onPressed: () {
            setState(() {
              ingredients.removeAt(index);
            });
          },
          child: const Icon(Icons.close, size: 15),
        ),
      ),
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
              heading("Ingredients"),
              Flexible(
                child: ListView.builder(
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      IngredientFields(
                        index: index,
                        updateRecipe: updateIngredient,
                      ),
                      Positioned(
                        top: 10,
                        right: 2,
                        child: deleteIngredientButton(index),
                      ),
                    ],
                  ),
                  shrinkWrap: true,
                ),
              ),
              addIngredientButton(),
              heading("Procedure"),
              procedureField(),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(
                  RecipeCreate()
                    ..name = nameController.text
                    ..procedure = procedureController.text
                    ..ingredients = ingredients,
                ),
                child: const Text(
                  "Add Recipe",
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
