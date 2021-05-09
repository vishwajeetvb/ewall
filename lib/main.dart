
import 'package:ewall/screens/auth/login_screen.dart';
import 'package:ewall/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //To hide the debug banner on homepage
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
        routes: {
          '/homePage' : (context)=>SignupScreen(),
          LoginScreen.routeName : (context)=>LoginScreen(),
          SignupScreen.routeName : (context)=>SignupScreen(),
        },
      );
  }
}

//Main Homepage widget added
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          //With this container added the side image big one
          Container(
            width: MediaQuery.of(context).size.width*0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/images/sideImg.png'),
                fit: BoxFit.cover
              )
            ),
          ),
          //With this container we add the side content of the image
          Container(
            width: MediaQuery.of(context).size.width*0.7,
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //This row will contain the content of top line which have time and image of cloud for temperature
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //This text to show the time on screen
                    Text("06:22 AM",style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w500
                    ),),
                    Expanded(
                        child: Container(),
                    ),
                    //This container to contain the corner image of cloud
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('asset/images/cloud.png'),
                          fit : BoxFit.contain
                        )
                      ),
                    ),
                    SizedBox(width: 3,),
                    //This text is to display the current temperature
                    Text("34 * C",style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w800
                    ),)
                  ],
                ),
                //This text for display of current date and day
                Text("Aug 1, 2020 | Wednesday", style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                ),),
                Expanded(child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //This container for the logo and for the content of rest of screen
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("asset/images/logo.png"),
                            fit: BoxFit.contain
                          )
                        ),
                      ),
                      //This text to display the ewall logo
                      Text("eWall", style: TextStyle(
                        fontSize: 50,
                        fontFamily: "ubuntu",
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      //This text to display the lucrative content
                      Text("Open An Account For \nDigital E-Wallet Solutions. \nInstant Payouts. \n\nJoin For Free", style: TextStyle(
                        color: Colors.grey
                      ),)
                    ],
                  ),
                ),),
                //This InkWell to provide user an tapping button to go to next page and sign up
                InkWell(
                  //When tap it will invoke openHomePage Method
                  onTap: openHomePage,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xffffac30),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      //This Row to write text inside our sign up button
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Sign Up", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                          ),),
                          Icon(
                            Icons.arrow_forward,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("Create an account",style: TextStyle(
                    fontSize: 16,
                  ),)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  //This Method to navigate to next page when click on sign up button
  void openHomePage(){
    Navigator.pushNamed(context, '/homePage');
  }
}
