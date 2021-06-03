
import 'package:ewall/screens/appScreen/home/home_page.dart';

import 'package:ewall/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

//Implementation of Intro Screen(First Screen)
class _IntroScreenState extends State<IntroScreen> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //This method check Whether User is logged In or not
  void _currentState(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Homepage(user: user)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //Whole Screen is implemented in Row Container
      body: Row(
        //It Have different children widgets
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

          //With this container we add the side content of the rest of the screen
          Container(
            //Used Media Query for rest of the screen
            width: MediaQuery.of(context).size.width*0.7,
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),

            //Implemented the rest as one column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              //It have children widgets
              children: [

                //This row will contain the content of top line which have Time
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

                  ],
                ),

                //This text for display of current date and day
                Text("Aug 1, 2020 | Wednesday", style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),),

                //Expanded Widget used to put the center content on screen
                Expanded(
                  child: Container(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //This container for the logo
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("asset/images/logo.png"),
                                fit: BoxFit.contain
                            )
                        ),
                      ),

                      //This text to display the ewall logo
                      Text("Trans", style: TextStyle(
                          fontSize: 50,
                          fontFamily: "ubuntu",
                          fontWeight: FontWeight.w600
                      ),),
                      Text("Manager", style: TextStyle(
                          fontSize: 50,
                          fontFamily: "ubuntu",
                          fontWeight: FontWeight.w600
                      ),),

                      SizedBox(height: 10,),

                      //This text to display the lucrative content
                      Text("Manage Our Transactions \nWith Instant Visuals \n\nJoin For Free", style: TextStyle(
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
                          Text("Let'\s Go", style: TextStyle(
                              fontSize: 20,
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
              ],
            ),
          )
        ],
      ),
    );
  }

  //This Method to navigate to next page when click on sign up button
  void openHomePage(){
    //Here in this navigator we push the screen to next Screen which is signupScreen
    _currentState();

  }
}

