import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testme/screens/addnewuser.dart';
import 'package:testme/screens/signin.dart';
import 'package:testme/screens/signup.dart';
import 'package:testme/screens/userlist.dart';
import 'package:testme/screens/userprofile.dart';
import 'package:testme/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: welcomeScreen(),
      initialRoute: welcomeScreen.path,
      routes: {
        welcomeScreen.path: (ctx) => welcomeScreen(),
        SigninScreen.path: (ctx) => SigninScreen(),
        SignUpScreen.path: (ctx) => SignUpScreen(),
        UserProfileScreen.path: (ctx) => UserProfileScreen(),
        UserList.path: (ctx) => UserList(),
        AddNewUsersScreen.path: (ctx) => AddNewUsersScreen(),
      },
    );
  }
}
