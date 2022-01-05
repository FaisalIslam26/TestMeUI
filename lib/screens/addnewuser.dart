import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testme/screens/profile.dart';
import 'package:testme/screens/userlist.dart';
import 'package:testme/screens/bottomnavlayout.dart';

class AddNewUsersScreen extends StatefulWidget {
  static const String path = "AddNewUsersScreen";
  const AddNewUsersScreen({Key? key}) : super(key: key);

  @override
  _AddNewUsersScreenState createState() => _AddNewUsersScreenState();
}

class _AddNewUsersScreenState extends State<AddNewUsersScreen> {
  bool ishiddenPassword = true;
  String _value = "Male";
  var imagePath;
  var imageURL;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControlller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool isLoading = false;

  Future signup() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordControlller.text);
      if (userCredential.user != null) {
        createProfile(
          nameController.text,
          emailController.text,
          mobileController.text,
          _value.toString(),
          imageURL.toString(),
        );

        Route route = MaterialPageRoute(builder: (ctx) => Profile());
        Navigator.push(context, route);
      }
    } catch (e) {
      print("Error: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  Future pickedImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = File(image.path);
      });
      uploadProfileImage();
    }
  }
  // Future pickedImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(
  //       source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
  //   if (image != null) {
  //     setState(() {
  //       imagePath = File(image.path);
  //     });
  //     uploadProfileImage();
  //   }
  // }

  Future uploadProfileImage() async {
    String image = imagePath.toString();
    var _image = image.split("/")[6];

    Reference reference =
        FirebaseStorage.instance.ref().child('profileImage/${_image}');
    UploadTask uploadTask = reference.putFile(imagePath);

    TaskSnapshot snapshot = await uploadTask;
    imageURL = await snapshot.ref.getDownloadURL();
  }

  Future createProfile(fullName, email, mobile, gender, profileImage) async {
    setState(() {
      isLoading = true;
    });
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      return users
          .add({
            'full_name': fullName,
            'email': email,
            'mobile': mobile,
            'gender': gender,
            'profile_image': profileImage
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print(e);
    }
  }

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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    imagePath != null
                        ? CircleAvatar(
                            radius: 36, backgroundImage: FileImage(imagePath))
                        : CircleAvatar(
                            radius: 36,
                            backgroundImage: AssetImage(
                              "assets/images/img_avatar.png",
                            ),
                          ),
                    Transform.translate(
                      offset: Offset(-20, 45),
                      child: ElevatedButton(
                        onPressed: () {
                          pickedImage();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 102,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: passwordControlller,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: Icon(ishiddenPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: mobileController,
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
                                value: "male",
                                groupValue: _value,
                                onChanged: (Value) {
                                  setState(() {
                                    _value = "male";
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
                                value: "Female",
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = "Female";
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, UserList.path);
                          createProfile(
                              nameController.text,
                              emailController.text,
                              mobileController.text,
                              _value.toString(),
                              imageURL.toString());
                        },
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
        ));
  }

  void _togglePasswordView() {
    // if (ishiddenPassword == true) {
    //   ishiddenPassword = false;
    // } else {
    //   ishiddenPassword = true;
    // }

    ishiddenPassword = !ishiddenPassword;
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