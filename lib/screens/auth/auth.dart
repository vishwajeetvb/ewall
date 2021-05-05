
import 'package:ewall/screens/appScreen/HomePage.dart';
import 'package:ewall/screens/auth/background_painter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email, _password ;

  //This Method To Check whether user is already logged in or loged out
  checkAuthentification() async
  {
    _auth.authStateChanges().listen((user) {
      if(user!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
    this.checkAuthentification();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _controller.view
                ),
              ),
          ),

        ],
      ),
    );
  }
}

