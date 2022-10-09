import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pantry_chef_app/pantry/models/food_item_create.dart';

typedef UpdateStorageLocation = void Function(StorageLocation);
final dateFormat = DateFormat('MM-dd-yyyy');

Widget nameAndQuantity(
    TextEditingController nameController,
    TextEditingController quantityController,
    TextEditingController unitController) {
  return Expanded(
    child: SizedBox(
      width: 200,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "food name",
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
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 65,
                child: TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    hintText: "amt",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextField(
                  controller: unitController,
                  decoration: InputDecoration(
                    hintText: "units",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget dateFields(String fieldName, TextEditingController controller,
    Future<DateTime?> Function(BuildContext, DateTime?) onShowPicker) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        fieldName,
        style: const TextStyle(fontSize: 16),
      ),
      IntrinsicWidth(
        child: DateTimeField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: 'Select',
          ),
          format: dateFormat,
          resetIcon: null,
          controller: controller,
          onShowPicker: onShowPicker,
        ),
      ),
    ],
  );
}

Widget foodLocation(StorageLocation? initialStorageLocation,
    UpdateStorageLocation updateStorageLocation) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("Keep in", style: TextStyle(fontSize: 16)),
      IntrinsicWidth(
        child: DropdownButtonFormField<StorageLocation>(
          decoration: const InputDecoration(hintText: 'Select'),
          value: initialStorageLocation,
          items: StorageLocation.values
              .map(
                (e) => DropdownMenuItem<StorageLocation>(
                  value: e,
                  child: Text(e.name.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: (value) => updateStorageLocation(value!),
        ),
      )
    ],
  );
}

Widget foodIcon() {
  return const Padding(
    padding: EdgeInsets.only(right: 24),
    child: FaIcon(
      FontAwesomeIcons.breadSlice,
      size: 50,
    ),
  );
}

Widget foodItemFormFields(
    TextEditingController nameController,
    TextEditingController quantityController,
    TextEditingController unitController,
    TextEditingController dateAddedController,
    TextEditingController useByController,
    StorageLocation? initialStorageLocation,
    UpdateStorageLocation updateStorageLocation) {
  return Column(
    children: [
      Row(
        children: [
          foodIcon(),
          nameAndQuantity(nameController, quantityController, unitController),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            dateFields(
              "Added on",
              dateAddedController,
              ((context, currentValue) async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: dateFormat.parse(dateAddedController.text),
                  firstDate: DateTime(2022),
                  lastDate: DateTime.now(),
                );
                return date;
              }),
            ),
            const SizedBox(height: 12),
            dateFields(
              "Use by",
              useByController,
              ((context, currentValue) async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: dateFormat.parse(useByController.text),
                  firstDate: dateFormat.parse(dateAddedController.text),
                  lastDate: DateTime(2024),
                );
                return date;
              }),
            ),
            const SizedBox(height: 12),
            foodLocation(initialStorageLocation, updateStorageLocation),
          ],
        ),
      ),
    ],
  );
}
