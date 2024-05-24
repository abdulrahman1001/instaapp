import 'package:flutter/material.dart';
import 'package:instaapp/view/loginpage.dart';

class appbarhomepage extends StatelessWidget {
  const appbarhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Instagram',
            style: TextStyle(fontSize: 30),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(
                Icons.logout,
                size: 30,
              )),
        ],
      ),
    );
  }
}
