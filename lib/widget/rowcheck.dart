import 'package:flutter/material.dart';
import 'package:instaapp/view/Register.dart';

class rowcheck extends StatelessWidget {
  const rowcheck({super.key, required this.anotherpage});
  final String anotherpage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('go to '),
        TextButton(
            onPressed: () {
              if (anotherpage == 'register') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Registerpage();
                }));
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(anotherpage))
      ],
    );
  }
}
