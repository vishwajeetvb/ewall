

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {

  static const routeName = '/signup';
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  User user = FirebaseAuth.instance.currentUser;

  _submit() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text)
      .then((value) => user.sendEmailVerification()).then((value) => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName))
      ;
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('SignUp Screen'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Login'),
                Icon(Icons.person)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.limeAccent,
                      Colors.red
                    ]
                )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty || !value.contains('@')){
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          onSaved: (value){

                          },
                        ),
                        //Password Field
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onSaved: (value){

                          },
                        ),
                        //Confirm Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty || value!=_passwordController.text){
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onSaved: (value){

                          },
                        ),
                        SizedBox(height: 30,),
                        //Button For Submission
                        RaisedButton(
                          child: Text('Submit'),
                          onPressed: (){
                            _submit();
                          },
                          shape : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color : Colors.blue,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
