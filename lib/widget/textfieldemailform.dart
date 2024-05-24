import 'package:flutter/material.dart';

class textfieldemailform extends StatelessWidget {
  const textfieldemailform({super.key, required this.onChanged});
final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChanged ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        hintText: 'Enter a valid email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}