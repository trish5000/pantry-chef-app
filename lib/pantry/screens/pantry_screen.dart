import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pantry_chef_app/pantry/models/food_item.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';
import 'package:pantry_chef_app/pantry/widgets/food_item_detail.dart';
import 'package:pantry_chef_app/pantry/widgets/new_input_dialog.dart';

class PantryScreen extends ConsumerStatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends ConsumerState<PantryScreen> {
  List<FoodItem> foodItems = [];
  FoodItem? currentFoodItem;

  @override
  void initState() {
    super.initState();
    _fetchPantryContents();
  }

  void _addFoodItem() async {
    final newFood = await showDialog<FoodItemCreate>(
        context: context, builder: (_) => const NewInputDialog());

    if (newFood == null) return;

    await ref.read(pantryServiceProvider).addToPantry(newFood);
    _fetchPantryContents();
  }

  void _removeFoodItem(FoodItem foodItem) async {
    await ref.read(pantryServiceProvider).deleteFoodItem(foodItem);
    _fetchPantryContents();
  }

  void _showFoodDetail() async {
    final maybeUpdated = await showDialog<FoodItem>(
      context: context,
      builder: (_) => FoodItemDetail(foodItem: currentFoodItem),
    );
    if (maybeUpdated == null) {
      return;
    }

    currentFoodItem!.name = maybeUpdated.name;
    currentFoodItem!.quantity = maybeUpdated.quantity;
    currentFoodItem!.unit = maybeUpdated.unit;
    currentFoodItem!.storageLocation = maybeUpdated.storageLocation;
    currentFoodItem!.dateAdded = maybeUpdated.dateAdded;
    currentFoodItem!.useBy = maybeUpdated.useBy;
    await ref.read(pantryServiceProvider).updateFoodItem(currentFoodItem!);
    _fetchPantryContents();
  }

  Future _fetchPantryContents() async {
    final pantryService = ref.read(pantryServiceProvider);
    final results = await pantryService.getPantry();

    setState(() {
      foodItems = results;
    });
  }

  Widget foodItemWidget(FoodItem foodItem) {
    return Card(
      child: Slidable(
        key: Key("food-item-${foodItem.name}"),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) => _removeFoodItem(foodItem)),
              icon: Icons.delete,
              backgroundColor: Colors.grey,
            )
          ],
        ),
        child: ListTile(
            title: Text(foodItem.name),
            leading: const FaIcon(FontAwesomeIcons.breadSlice),
            trailing: Text("${foodItem.quantity} ${foodItem.unit}"),
            visualDensity: const VisualDensity(vertical: 4),
            tileColor: Colors.white,
            onTap: () {
              currentFoodItem = foodItem;
              _showFoodDetail();
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Pantry")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: foodItems.length,
          itemBuilder: (context, index) {
            return foodItemWidget(foodItems[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFoodItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
