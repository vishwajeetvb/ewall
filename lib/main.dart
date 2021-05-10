

import 'package:ewall/screens/appScreen/home/HomeWithSideBar.dart';
import 'package:ewall/screens/appScreen/startingScreen/firstScreen.dart';
import 'package:ewall/screens/auth/login_screen.dart';
import 'package:ewall/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //To hide the debug banner on homepage
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
        routes: {
          '/homePage' : (context)=>HomeWithSideBar(),
          LoginScreen.routeName : (context)=>LoginScreen(),
          SignupScreen.routeName : (context)=>SignupScreen(),
          HomeWithSideBar.routeName : (context) => HomeWithSideBar(),
        },
      );
  }
}


