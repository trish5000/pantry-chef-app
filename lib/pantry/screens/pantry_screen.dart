import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pantry_chef_app/pantry/models/pantry_item.dart';
import 'package:pantry_chef_app/pantry/models/pantry_item_create.dart';
import 'package:pantry_chef_app/pantry/services/pantry_service.dart';
import 'package:pantry_chef_app/pantry/widgets/pantry_item_detail.dart';
import 'package:pantry_chef_app/pantry/widgets/new_input_dialog.dart';

class PantryScreen extends ConsumerStatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends ConsumerState<PantryScreen> {
  List<PantryItem> pantryItems = [];
  PantryItem? currentPantryItem;

  @override
  void initState() {
    super.initState();
    _fetchPantryContents();
  }

  void _addPantryItem() async {
    final newFood = await showDialog<PantryItemCreate>(
        context: context, builder: (_) => const NewInputDialog());

    if (newFood == null) return;

    await ref.read(pantryServiceProvider).addToPantry(newFood);
    _fetchPantryContents();
  }

  void _removePantryItem(PantryItem pantryItem) async {
    await ref.read(pantryServiceProvider).deletePantryItem(pantryItem);
    _fetchPantryContents();
  }

  void _showFoodDetail() async {
    final maybeUpdated = await showDialog<PantryItem>(
      context: context,
      builder: (_) => PantryItemDetail(pantryItem: currentPantryItem),
    );
    if (maybeUpdated == null) {
      return;
    }

    currentPantryItem!.name = maybeUpdated.name;
    currentPantryItem!.quantity = maybeUpdated.quantity;
    currentPantryItem!.unit = maybeUpdated.unit;
    currentPantryItem!.storageLocation = maybeUpdated.storageLocation;
    currentPantryItem!.dateAdded = maybeUpdated.dateAdded;
    currentPantryItem!.useBy = maybeUpdated.useBy;
    await ref.read(pantryServiceProvider).updatePantryItem(currentPantryItem!);
    _fetchPantryContents();
  }

  Future _fetchPantryContents() async {
    final pantryService = ref.read(pantryServiceProvider);
    final results = await pantryService.getPantry();

    setState(() {
      pantryItems = results;
    });
  }

  Widget pantryItemWidget(PantryItem pantryItem) {
    return Card(
      child: Slidable(
        key: Key("food-item-${pantryItem.name}"),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) => _removePantryItem(pantryItem)),
              icon: Icons.delete,
              backgroundColor: Colors.grey,
            )
          ],
        ),
        child: ListTile(
            title: Text(pantryItem.name),
            leading: const FaIcon(FontAwesomeIcons.breadSlice),
            trailing: Text("${pantryItem.quantity} ${pantryItem.unit}"),
            visualDensity: const VisualDensity(vertical: 4),
            tileColor: Colors.white,
            onTap: () {
              currentPantryItem = pantryItem;
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
          itemCount: pantryItems.length,
          itemBuilder: (context, index) {
            return pantryItemWidget(pantryItems[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPantryItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
