import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ForgetPassword extends StatefulWidget {
  final User user;
  const ForgetPassword({@required Key key,@required this.user}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _forgetFormKey = GlobalKey<FormState>();
  TextEditingController forgemailInputController = new TextEditingController();

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


  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Fluttertoast.showToast(
        msg: "Email Sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Forget Password"),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _forgetFormKey,
                  child: Column(
                    children: <Widget>[
                      Container(

                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email*', hintText: "user@gmail.com"),
                          controller: forgemailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                        child: Text("Send Reset Link"),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_forgetFormKey.currentState.validate()){
                            resetPassword(forgemailInputController.text);
                          }
                        },
                      ),
                      SizedBox(height: 10,),
                      FlatButton(
                        child: Text("Back To Login"),
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage(user: widget.user,)),
                          );


                        },
                      ),

                    ],
                  ),
                ))));
  }
}
