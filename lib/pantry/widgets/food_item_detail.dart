import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pantry_chef_app/pantry/models/food_item.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';
import 'package:pantry_chef_app/pantry/widgets/food_item_fields.dart';

class FoodItemDetail extends ConsumerStatefulWidget {
  final FoodItem? foodItem;
  const FoodItemDetail({Key? key, required this.foodItem}) : super(key: key);

  @override
  ConsumerState<FoodItemDetail> createState() => _FoodItemDetailState();
}

class _FoodItemDetailState extends ConsumerState<FoodItemDetail> {
  late TextEditingController nameController,
      quantityController,
      unitController,
      dateAddedController,
      useByController;
  late StorageLocation storageLocation;
  static final dateFormat = DateFormat('MM-dd-yyyy');
  bool formComplete = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.foodItem!.name)
      ..addListener(checkFormComplete);
    quantityController =
        TextEditingController(text: widget.foodItem!.quantity.toString())
          ..addListener(checkFormComplete);
    unitController = TextEditingController(text: widget.foodItem!.unit)
      ..addListener(checkFormComplete);
    dateAddedController = TextEditingController(
      text: dateFormat.format(widget.foodItem!.dateAdded),
    );
    useByController = TextEditingController(
      text: dateFormat.format(widget.foodItem!.useBy),
    );
    storageLocation = widget.foodItem!.storageLocation;
  }

  bool wasEdited(FoodItem foodItem) {
    if (foodItem.name == widget.foodItem!.name &&
        foodItem.quantity == widget.foodItem!.quantity &&
        foodItem.unit == widget.foodItem!.unit &&
        foodItem.storageLocation == widget.foodItem!.storageLocation &&
        foodItem.dateAdded == widget.foodItem!.dateAdded &&
        foodItem.useBy == widget.foodItem!.useBy) {
      return false;
    }
    return true;
  }

  void updateStorageLocation(StorageLocation newStorageLocation) {
    setState(() {
      storageLocation = newStorageLocation;
    });
  }

  void checkFormComplete() {
    final currentState = nameController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        unitController.text.isNotEmpty;

    if (formComplete != currentState) {
      setState(() {
        formComplete = currentState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(25),
      children: [
        foodItemFormFields(
          nameController,
          quantityController,
          unitController,
          dateAddedController,
          useByController,
          storageLocation,
          updateStorageLocation,
        ),
        TextButton(
          onPressed: formComplete
              ? () {
                  final foodItem = FoodItem()
                    ..name = nameController.text
                    ..quantity = double.parse(quantityController.text)
                    ..unit = unitController.text
                    ..storageLocation = storageLocation
                    ..dateAdded = dateFormat.parse(dateAddedController.text)
                    ..useBy = dateFormat.parse(useByController.text);
                  if (wasEdited(foodItem)) {
                    Navigator.of(context).pop(foodItem);
                  } else {
                    Navigator.of(context).pop(null);
                  }
                }
              : null,
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "OK",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
