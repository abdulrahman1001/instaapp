import 'package:flutter/material.dart';
import 'package:instaapp/cubit/cubit/fetshuserdata_cubit.dart';
import 'package:instaapp/widget/appbarhomepage.dart';
import 'package:instaapp/widget/homescreenlistview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print('ffffffffffffffffff');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [appbarhomepage(), Expanded(child: homescreenlistview())],
      ),
    );
  }
}
