import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.title, required this.clickFunction});

  final String title;
  final Function clickFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          focusedErrorBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          errorStyle: const TextStyle(color: Colors.purple),
        ),
        validator: (value) {
          if (value == null || value.trim() == '') {
            return 'Cannot be empty';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => clickFunction(value),
      );
  }
}