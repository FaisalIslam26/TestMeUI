import 'package:flutter/material.dart';

import 'package:testme/screens/profile.dart';
import 'package:testme/screens/signup.dart';
import 'package:testme/screens/bottomnavlayout.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninScreen extends StatefulWidget {
  static const String path = "signinScreen";
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool ishiddenPassword = true;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControlller = TextEditingController();

  Future signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordControlller.text);
      if (userCredential.user != null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Enter your email address and password to access your account",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          color: Color(0xffF2F2F7),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              // labelText: "Email",
                              hintText: "Email",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          color: Color(0xffF2F2F7),
                          child: TextFormField(
                            controller: passwordControlller,
                            obscureText: ishiddenPassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // labelText: "Password",
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
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            isLoading
                                ? CircularProgressIndicator()
                                : Container(
                                    // margin: EdgeInsets.symmetric(horizontal: ),
                                    width: 450,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        signIn();
                                        // Navigator.pushNamed(context, Profile.path);
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 140),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Don't have an account?"),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, SignUpScreen.path);
                                            },
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
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
