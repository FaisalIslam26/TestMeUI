import 'package:flutter/material.dart';
import 'package:testme/screens/addnewuser.dart';

class UserList extends StatelessWidget {
  static const String path = "UserList";
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: CustomUserlist(),
    );
  }
}

class CustomUserlist extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomUserlist({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Text(
            "User List",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Divider(
            thickness: 1,
          ),
          // SizedBox(
          //   height: 24,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.person),
                    Text(
                      "Total user",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      "15",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewUsersScreen()));
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                  label: Text("Add New User"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              fillColor: Color(0xffF2F2F7),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xffF2F2F7)),
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, int) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage("assets/images/PP.jpg"),
                  ),
                  title: Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Are you sure?"),
                          content: Container(
                            height: 188,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                              onPressed: () {},
                              child: Text("Confirm"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Remove",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(71, 32),
                      primary: Colors.grey.withOpacity(0.50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7), // <-- Radius
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
