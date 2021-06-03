import 'package:ewall/screens/appScreen/home/home_page.dart';
import 'package:ewall/screens/auth/forget_password.dart';
import 'package:ewall/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  final User user;
  LoginPage({Key key,this.user}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      Container(

                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email*', hintText: "john.doe@gmail.com"),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                      ),
                      Container(

                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password*', hintText: "********"),
                          controller: pwdInputController,
                          obscureText: true,
                          validator: pwdValidator,
                        ),
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                        child: Text("Login"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_loginFormKey.currentState.validate()) {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: emailInputController.text,
                                password: pwdInputController.text)
                                .then((currentUser) => FirebaseFirestore.instance
                                .collection("users")
                                .doc(currentUser.user.uid)
                                .get().then((value) {
                                  if(currentUser.user.emailVerified){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage(
                                              user: currentUser.user,
                                            )));
                                  }else{
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text("Attention"),
                                        content: Text("Please Verify Email First"),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("Sure"),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                })
                                .catchError((err) => print(err)))
                                .catchError((err) => print(err));
                          }
                        },
                      ),
                      Text("Don't have an account yet?"),
                      FlatButton(
                        child: Text("Register here!"),
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                      ),
                      FlatButton(
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ForgetPassword(user: widget.user,)),
                          );
                        },
                        textColor: Colors.blue,
                        child: Text('Forgot Password'),
                      ),
                    ],
                  ),
                ))));
  }
}