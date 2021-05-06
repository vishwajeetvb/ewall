
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Login Screen'),
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
                        RaisedButton(
                            child: Text('Submit'),
                            onPressed: (){

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
