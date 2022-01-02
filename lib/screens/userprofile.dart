import 'package:flutter/material.dart';
import 'package:testme/screens/addnewuser.dart';
import 'package:testme/screens/userlist.dart';

class UserProfileScreen extends StatefulWidget {
  static const String path = "UserProfileScreen";
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int selectedIndex = 0;
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

    // Container(
    //   width: double.infinity,
    //   height: double.infinity,
    //   color: Colors.white,
    // ),
    CustomProfileWidget()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: screens.elementAt(selectedIndex),
    );
  }
}

class CustomProfileWidget extends StatelessWidget {
  const CustomProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Profile",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 140),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/PP.jpg"),
                        radius: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Text(
                            "Khandokar Faisal Islam",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "faisal2619@gmail.com",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Phone: 01674203635",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 34,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Created Date & Time: 12/12/2021 06.30AM",
                            style: TextStyle(
                              color: Color(0xff504F4FCF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                Text("Location")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/images/location.png"),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 11.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
