
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

  //Logic of Register Button
  _submit() async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text)
      .then((value) => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen())))
      ;
    } on FirebaseAuthException catch  (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context,"Error","Password Provided is too-weak",'Try Again',SignupScreen.routeName),
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context,"Error","Account Already Exists for That Email",'Try Again',SignupScreen.routeName),
        );
      }
    }

  }

  //Main Widget Logic of SignUp Page
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
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

//PopUp Method logic
Widget _buildPopupDialog(BuildContext context,String header,String text,String buttonText,[var routeName]) {
  return new AlertDialog(
    //Title Text
    title: Text(header),

    //Column used for that text display on popup
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text which we need to display on Screen
        Text(text),
      ],
    ),

    //Action widget what to do when pressed Button
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          //Navigate user to Specified routePage passed in parameter
          Navigator.of(context).pushReplacementNamed(routeName);
        },
        textColor: Theme.of(context).primaryColor,
        child: Text(buttonText),
      ),
    ],
  );
}

