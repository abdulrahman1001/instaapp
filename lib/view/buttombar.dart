import 'package:flutter/material.dart';
import 'package:instaapp/cubit/cubit/authtecate_cubit.dart';
import 'package:instaapp/cubit/cubit/fetshuserdata_cubit.dart';
import 'package:instaapp/view/addpostpage.dart';
import 'package:instaapp/view/homepage.dart';
import 'package:instaapp/view/profilepage.dart';
import 'package:instaapp/view/searchpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BottomBarpage extends StatefulWidget {
  // Renamed for consistency
  const BottomBarpage({Key? key}) : super(key: key);

  @override
  State<BottomBarpage> createState() => _BottomBarpageState();
}

class _BottomBarpageState extends State<BottomBarpage> {
  int _selectedIndex = 0; // To keep track of the selected index

  // A list of widgets to display based on the selected index
  final List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    searchpage(),
    AddPostPage(),
    profilepage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetshuserdataCubit(),

        ),
        BlocProvider(
          create: (context) => AuthtecateCubit(),

        ),
        
      ],
  
      child: Scaffold(
        body: Center(
          child: _widgetOptions
              .elementAt(_selectedIndex), // Display the correct widget
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, // Set the current index
          onTap: _onItemTapped, // Handle item taps
          type: BottomNavigationBarType
              .fixed, // Optional: Ensures all labels are visible
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.amber, size: 26),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.amber, size: 26),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.amber, size: 26),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.amber, size: 26),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
