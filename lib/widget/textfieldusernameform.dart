import 'package:flutter/material.dart';

class textfieldusernameform extends StatelessWidget {
  const textfieldusernameform({super.key, required this.onChanged});
final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChanged ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Username',
        hintText: 'Enter a valid username',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
  