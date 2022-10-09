import 'package:flutter/material.dart';

class DeleteRecipeDialog extends StatelessWidget {
  final String recipeName;
  const DeleteRecipeDialog({Key? key, required this.recipeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actionsPadding: const EdgeInsets.only(bottom: 25),
        title: Center(
          child: Text('Delete $recipeName recipe?'),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              const SizedBox(width: 40),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              )
            ],
          )
        ]);
  }
}
