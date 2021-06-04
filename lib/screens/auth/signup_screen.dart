import 'package:ewall/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
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
          title: Text("Register"),
            backgroundColor: Color(0xffffac30)
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'First Name*', hintText: "UserFirstName"),
                    controller: firstNameInputController,
                    validator: (value) {
                      if (value.length < 3) {
                        return ("Please enter a valid first name.");
                      }
                    },
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Last Name*', hintText: "UserLastName"),
                      controller: lastNameInputController,
                      validator: (value) {
                        if (value.length < 3) {
                          return "Please enter a valid last name.";
                        }
                      }),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email*', hintText: "user@gmail.com"),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password*', hintText: "********"),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password*', hintText: "********"),
                    controller: confirmPwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  RaisedButton(
                    color: Color(0xffffac30),
                    child: Text("Register"),
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_registerFormKey.currentState.validate()) {
                        if (pwdInputController.text ==
                            confirmPwdInputController.text) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: pwdInputController.text)
                              .then((currentUser) => FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(currentUser.user.uid)
                                      .set({
                                    "uid": currentUser.user.uid,
                                    "firstname": firstNameInputController.text,
                                    "lastname": lastNameInputController.text,
                                    "email": emailInputController.text,
                                  }).then((value) async {
                                    try {
                                      await currentUser.user
                                          .sendEmailVerification();
                                      Fluttertoast.showToast(
                                          msg: "Verification Email Sent",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                          textColor: Colors.black,
                                          fontSize: 16.0
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginPage(
                                                  user: currentUser.user)),
                                         );
                                      firstNameInputController.clear();
                                      lastNameInputController.clear();
                                      emailInputController.clear();
                                      pwdInputController.clear();
                                      confirmPwdInputController.clear();
                                    } catch (e) {
                                      print(
                                          "An error occurred while trying to send email verification");
                                      print(e.message);
                                    }
                                  }).catchError((err) => print(err)))
                              .catchError((err) => print(err));
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("The passwords do not match"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      }
                    },
                  ),
                  Text("Already have an account?"),
                  FlatButton(
                    color: Color(0xffffac30),
                    child: Text("Login here!"),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  )
                ],
              ),
            ))));
  }
}
