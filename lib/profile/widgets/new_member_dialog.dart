import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/profile/models/household_member_create.dart';

class NewMemberDialog extends ConsumerStatefulWidget {
  const NewMemberDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<NewMemberDialog> createState() => _NewMemberDialogState();
}

class _NewMemberDialogState extends ConsumerState<NewMemberDialog> {
  bool formComplete = false;
  late TextEditingController firstNameController, lastNameController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController()
      ..addListener(checkFormComplete);
    lastNameController = TextEditingController()
      ..addListener(checkFormComplete);
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  void checkFormComplete() {
    final currentState = firstNameController.text.isNotEmpty;

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
      title: const Text("add new household member"),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: firstNameController,
                decoration: inputDecoration("first name"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: lastNameController,
                decoration: inputDecoration("last name"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: formComplete
              ? () => Navigator.of(context).pop(
                    HouseholdMemberCreate()
                      ..firstName = firstNameController.text
                      ..lastName = lastNameController.text.isEmpty
                          ? null
                          : lastNameController.text,
                  )
              : null,
          child: const Text('add'),
        ),
      ],
    );
  }
}
