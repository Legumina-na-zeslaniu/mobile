import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:junction_frame/themes/colors.dart';

class InputItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isEditing;
  final bool isMultiline;
  final Widget? titleIcon;
  final TextEditingController? controller;

  const InputItem(
      {super.key,
      this.titleIcon,
      this.isMultiline = false,
      required this.title,
      required this.value,
      this.controller,
      this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    var controller = this.controller ?? TextEditingController(text: value);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          if (titleIcon != null) titleIcon!,
        ],
      ),
      TextField(
        controller: controller,
        enabled: isEditing,
        keyboardType: isMultiline ? TextInputType.multiline : null,
        maxLines: isMultiline ? null : 1,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        decoration: const InputDecoration(
            labelText: '',
            hintText: '',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.orange)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.orange)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.orange)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.orange))),
      ),
      const SizedBox(
        height: 3,
      )
    ]);
  }
}
