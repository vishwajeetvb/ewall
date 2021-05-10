
import 'package:ewall/screens/appScreen/home/HomePage.dart';
import 'package:ewall/screens/appScreen/home/HomeWithSideBar.dart';
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

  //Instance of firebase created
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Two controller variable to get data from email & password field
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  User user = FirebaseAuth.instance.currentUser;

  //Logic of Login Button
  void _submit() async{

     //Calling method to create user with email & password
     await _firebaseAuth.signInWithEmailAndPassword(
         email: _emailController.text, password : _passwordController.text)
     ;

     //if user email is not verified or not
     if (!user.emailVerified) {
       //Pop up dialog box & say Please verify your email
       showDialog(
         context: context,
         builder: (BuildContext context) => _buildPopupDialog(context,"Important","Please Verify your Email",'Verify Email',LoginScreen.routeName),
       );
     }else{
       //If its verified pop up & say login successfull & redirect to home screen
       showDialog(
         context: context,
         builder: (BuildContext context) => _buildPopupDialog(context,"Success","Login Successfull",'Let\'s Go',HomeWithSideBar.routeName),
       );
     }
     }

  //Main Widget of LoginScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //AppBar Used For Top of Login Screen
      appBar: AppBar(

        //Text to display Login Screen
        title: Text('Login Screen'),

        //To Give a SignUp Button when pressed navigate to signup Screen
        actions: <Widget>[
          FlatButton(

              //Row used to show signup
              child: Row(
                children: <Widget>[
                  Text('SignUp'),
                  Icon(Icons.person_add)
                ],
              ),
              textColor: Colors.white,

              //Redirect User to Signup Page When click on it
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignupScreen()));
              },
          )
        ],
      ),

      //Body of the Screen
      body: Stack(
        //Many widgets used to build the boyd
        children: <Widget>[
          //Container to give the screen gradient Colour
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

          //In Center, Card Used to Provide the Form For Login
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

                  //ScrollView is used so that when keyboard open it gets scrolled up
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

                        //Button For Submission Or To Login
                        RaisedButton(
                            child: Text('Submit'),

                            //When Clicked on Submit invoke Submit Method
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