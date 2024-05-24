import 'package:flutter/material.dart';

class textfieldpasswpdform extends StatelessWidget {
  const textfieldpasswpdform({super.key, required this.onChanged});
final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged:onChanged ,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          hintText: 'Enter a valid password',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          if (value.length < 9) {
            return 'Password must be at least 9 characters long';
          }
          return null;
        });
  }
}
