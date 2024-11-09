import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isEditing;
  final bool isMultiline;

  const InputItem(
      {super.key,
      this.isMultiline = false,
      required this.title,
      required this.value,
      this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value);

    return Column(children: [
      Text(title),
      TextField(
        controller: controller,
        enabled: isEditing,
        keyboardType: isMultiline ? TextInputType.multiline : null,
        maxLines: isMultiline ? null : 1,
        decoration: const InputDecoration(
            labelText: '',
            hintText: '',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      )
    ]);
  }
}
