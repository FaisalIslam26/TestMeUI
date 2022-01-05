import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:testme/screens/profile.dart';
import 'package:testme/screens/signin.dart';
import 'package:testme/screens/bottomnavlayout.dart';
import 'package:testme/screens/userlist.dart';
import 'package:testme/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  static const String path = "SignUpScreen";
  final TextEditingController? controller;

  const SignUpScreen({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    setState(() {
      isLoading = true;
    });
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

        Route route = MaterialPageRoute(builder: (ctx) => BottomNavLayout());
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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              child: Form(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 15),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Center(
                        child: Stack(
                          children: [
                            imagePath != null
                                ? CircleAvatar(
                                    radius: 36,
                                    backgroundImage: FileImage(imagePath))
                                : CircleAvatar(
                                    radius: 36,
                                    backgroundImage: AssetImage(
                                        "assets/images/img_avatar.png")),
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
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Color(0xffF2F2F7),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              hintText: "Name",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Color(0xffF2F2F7),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              hintText: "Email",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Color(0xffF2F2F7),
                          child: TextFormField(
                            controller: passwordControlller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              hintText: "Password",
                              suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(ishiddenPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Color(0xffF2F2F7),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: "Enter Mobile Number",
                                suffixText: "Verify"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: "Male",
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = "Male";
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Male"),
                                Radio(
                                  value: "Female",
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = "Female";
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Female"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, UserList.path);
                                    signup();
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SigninScreen.path);
                            },
                            child: Text("Login"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, welcomeScreen.path);
              },
              icon: Icon(Icons.arrow_back_ios_new),
              label: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    // if (ishiddenPassword == true) {
    //   ishiddenPassword = false;
    // } else {
    //   ishiddenPassword = true;
    // }
    setState(() {
      ishiddenPassword = !ishiddenPassword;
    });
  }
}

void createProfile(
    String text, String text2, String text3, int int, String string) {}
