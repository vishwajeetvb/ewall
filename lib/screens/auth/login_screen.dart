
import 'package:ewall/screens/appScreen/HomePage.dart';
import 'package:ewall/screens/appScreen/HomeWithSideBar.dart';
import 'package:ewall/screens/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  User user = FirebaseAuth.instance.currentUser;

  void _submit() async{
     await _firebaseAuth.signInWithEmailAndPassword(
         email: _emailController.text, password : _passwordController.text)
         .then((value) => print("Login Successfull"))
     ;
     if (!user.emailVerified) {
       showDialog(
         context: context,
         builder: (BuildContext context) => _buildPopupDialog(context,"Please Verify your Email"),
       );
     }else{
       Navigator.of(context).pushReplacementNamed(HomeWithSideBar.routeName);
     }
     }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Login Screen'),
        actions: <Widget>[
          FlatButton(
              child: Row(
                children: <Widget>[
                  Text('SignUp'),
                  Icon(Icons.person_add)
                ],
              ),
              textColor: Colors.white,
              onPressed: (){
                  Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
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
                  Colors.lightGreenAccent,
                  Colors.blue
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
                height: 260,
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
                            if(value.isEmpty || value.contains('@')){
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          onSaved: (value){},
                        ),
                        //Password Field
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty || value.length<=5){
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

//PopUp Builder
Widget _buildPopupDialog(BuildContext context, String text) {
  return new AlertDialog(
    title: const Text('Important'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}