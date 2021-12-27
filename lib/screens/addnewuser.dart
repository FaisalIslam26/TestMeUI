import 'package:flutter/material.dart';

class AddNewUsersScreen extends StatelessWidget {
  const AddNewUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Add New User",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: NewUsers(),
    );
  }
}

class NewUsers extends StatefulWidget {
  const NewUsers({
    Key? key,
  }) : super(key: key);

  @override
  State<NewUsers> createState() => _NewUsersState();
}

class _NewUsersState extends State<NewUsers> {
  @override
  Widget build(BuildContext context) {
    int _value = 1;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/PP.jpg"),
                  radius: 36,
                ),
                Transform.translate(
                  offset: Offset(-20, 45),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 102,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: Icon(Icons.visibility),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: "Phone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gender",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Radio(
                            value: 1,
                            groupValue: _value,
                            onChanged: (Value) {
                              setState(() {
                                _value = 1;
                              });
                            }),
                        SizedBox(width: 43),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Female",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Radio(
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = 2;
                              });
                            }),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: AssetImage("assets/images/PP.jpg"),
//                       radius: 36,
//                     ),
//                     Transform.translate(
//                       offset: Offset(-20, 45),
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         child: Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           shape: CircleBorder(),
//                           primary: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 102,
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Name",
//                 ),
//               ),
//               SizedBox(height: 12),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Email",
//                 ),
//               ),
//               SizedBox(height: 12),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Password",
//                   suffixIcon: Icon(Icons.visibility),
//                 ),
//               ),
//               SizedBox(height: 12),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Phone",
//                 ),
//               ),
//               SizedBox(height: 12),
//               Row(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Male",
//                         style: TextStyle(
//                           fontSize: 19,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Radio(
//                           value: 1,
//                           groupValue: _value,
//                           onChanged: (Value) {
//                             setState(() {
//                               _value = 1;
//                             });
//                           }),
//                       SizedBox(width: 43),
//                       Row(
//                         children: [
//                           Text(
//                             "Female",
//                             style: TextStyle(
//                               fontSize: 19,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Radio(
//                               value: 2,
//                               groupValue: _value,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _value = 2;
//                                 });
//                               }),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Save",
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 48),
//                   primary: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );