import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pantry_chef_app/pantry/models/pantry_item.dart';
import 'package:pantry_chef_app/pantry/models/pantry_item_create.dart';
import 'package:pantry_chef_app/pantry/widgets/pantry_item_fields.dart';

class PantryItemDetail extends ConsumerStatefulWidget {
  final PantryItem? pantryItem;
  const PantryItemDetail({Key? key, required this.pantryItem})
      : super(key: key);

  @override
  ConsumerState<PantryItemDetail> createState() => _PantryItemDetailState();
}

class _PantryItemDetailState extends ConsumerState<PantryItemDetail> {
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
    nameController = TextEditingController(text: widget.pantryItem!.name)
      ..addListener(checkFormComplete);
    quantityController =
        TextEditingController(text: widget.pantryItem!.quantity.toString())
          ..addListener(checkFormComplete);
    unitController = TextEditingController(text: widget.pantryItem!.unit)
      ..addListener(checkFormComplete);
    dateAddedController = TextEditingController(
      text: dateFormat.format(widget.pantryItem!.dateAdded),
    );
    useByController = TextEditingController(
      text: dateFormat.format(widget.pantryItem!.useBy),
    );
    storageLocation = widget.pantryItem!.storageLocation;
  }

  bool wasEdited(PantryItem pantryItem) {
    if (pantryItem.name == widget.pantryItem!.name &&
        pantryItem.quantity == widget.pantryItem!.quantity &&
        pantryItem.unit == widget.pantryItem!.unit &&
        pantryItem.storageLocation == widget.pantryItem!.storageLocation &&
        pantryItem.dateAdded == widget.pantryItem!.dateAdded &&
        pantryItem.useBy == widget.pantryItem!.useBy) {
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
        pantryItemFormFields(
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
                  final pantryItem = PantryItem()
                    ..name = nameController.text
                    ..quantity = double.parse(quantityController.text)
                    ..unit = unitController.text
                    ..storageLocation = storageLocation
                    ..dateAdded = dateFormat.parse(dateAddedController.text)
                    ..useBy = dateFormat.parse(useByController.text);
                  if (wasEdited(pantryItem)) {
                    Navigator.of(context).pop(pantryItem);
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
