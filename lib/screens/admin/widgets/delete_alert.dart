import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  final VoidCallback deleteOnPressed;
    final VoidCallback cancelOnpressed;

  final  String message;
  const DeleteAlert({super.key, required this.message, required this.deleteOnPressed, required this.cancelOnpressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text('delete'),
      content: Text(message),
      actions: [
        TextButton(onPressed: cancelOnpressed, child:const Text('close')),
        TextButton(
            onPressed:deleteOnPressed,
            child:const Text('delete')),
      ],
    );
  }
}
