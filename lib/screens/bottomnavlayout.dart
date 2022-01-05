import 'package:flutter/material.dart';
import 'package:testme/screens/profile.dart';
import 'package:testme/screens/userlist.dart';

class BottomNavLayout extends StatefulWidget {
  static const String path = "BottomNavLayout";
  const BottomNavLayout({Key? key}) : super(key: key);

  @override
  State<BottomNavLayout> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  int selectedIndex = 1;
  List<Widget> screens = [
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
    ),
    //  NewUsers(),
    // Container(
    //   width: double.infinity,
    //   height: double.infinity,
    //   color: Colors.green,
    // ),
    UserList(),

    Profile(),

    // Container(
    //   width: double.infinity,
    //   height: double.infinity,
    //   color: Colors.white,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(selectedIndex),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app), label: "Exit"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Users"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: " Profile")
          ],
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: Colors.black,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
        ),
      ),

      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "Profile",
      //     style: TextStyle(
      //       fontSize: 18,
      //       fontWeight: FontWeight.w500,
      //       color: Colors.black,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
    );
  }
}
