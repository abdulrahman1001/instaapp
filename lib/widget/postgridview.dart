import 'package:flutter/material.dart';

class postgridview extends StatelessWidget {
  const postgridview({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
            child: GridView.builder(
          
              scrollDirection: Axis.vertical,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 2,mainAxisSpacing: 5,crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.amber,
                );
              },
              itemCount: 30,
              // shrinkWrap: true,
            ),
          );
  }
}