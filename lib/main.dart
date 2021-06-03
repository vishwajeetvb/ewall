import 'package:ewall/screens/appScreen/home/home_page.dart';
import 'package:ewall/screens/appScreen/startingScreen/firstScreen.dart';
import 'package:ewall/screens/auth/login_screen.dart';
import 'package:ewall/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

/*This is Main function where we are running the MyApp
Initializing Firebase which return Future
So await which need async */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(home: new Scaffold(body: new MyApp())));
}

/*
  MyApp class which have set IntroScreen as its home
  and have routes of different screen
*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //To hide the debug banner on homepage
      debugShowCheckedModeBanner: false,
      //homeScreen set to introScreen which is first page of Screen
      home: IntroScreen(),
      //These routes to set particular screen by calling their router Name
      routes: {
        '/home': (BuildContext context) => Homepage(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
