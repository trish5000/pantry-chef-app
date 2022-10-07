import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';
import 'package:pantry_chef_app/pantry/widgets/food_item_fields.dart';

class NewInputDialog extends ConsumerStatefulWidget {
  const NewInputDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<NewInputDialog> createState() => _NewInputDialogState();
}

class _NewInputDialogState extends ConsumerState<NewInputDialog> {
  late TextEditingController nameController,
      quantityController,
      unitController,
      dateAddedController,
      useByController;
  StorageLocation? storageLocation;
  static final dateFormat = DateFormat('MM-dd-yyyy');
  bool formComplete = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController()..addListener(checkFormComplete);
    quantityController = TextEditingController()
      ..addListener(checkFormComplete);
    unitController = TextEditingController()..addListener(checkFormComplete);
    dateAddedController = TextEditingController(
      text: dateFormat.format(DateTime.now()),
    );
    useByController = TextEditingController(
      text: dateFormat.format(DateTime.now()),
    );
  }

  void updateStorageLocation(StorageLocation newStorageLocation) {
    setState(() {
      storageLocation = newStorageLocation;
    });
    checkFormComplete();
  }

  void checkFormComplete() {
    final currentState = nameController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        unitController.text.isNotEmpty &&
        storageLocation != null;

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
              ? () => Navigator.of(context).pop(
                    FoodItemCreate()
                      ..name = nameController.text
                      ..quantity = double.parse(quantityController.text)
                      ..unit = unitController.text
                      ..storageLocation = storageLocation!
                      ..dateAdded = dateFormat.parse(dateAddedController.text)
                      ..useBy = dateFormat.parse(useByController.text),
                  )
              : null,
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Add to Pantry",
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
