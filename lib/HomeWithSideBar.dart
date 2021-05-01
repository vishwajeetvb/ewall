import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class HomeWithSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeWithSidebar(),
    );
  }
}

class HomeWithSidebar extends StatefulWidget {
  @override
  _HomeWithSidebarState createState() => _HomeWithSidebarState();
}

class _HomeWithSidebarState extends State<HomeWithSidebar> {
  bool sideBarActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f3f6),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width*0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xfff1f3f6),
                              image: DecorationImage(
                                image: AssetImage('asset/images/avatar4.png'),
                                fit: BoxFit.contain
                              )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vishwajeet Behera", style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),),
                              Text("Panipat Haryana", style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      navigatorTitle("Home", true),
                      navigatorTitle("Profile", false),
                      navigatorTitle("Accounts", false),
                      navigatorTitle("Transactions", false),
                      navigatorTitle("Stats", false),
                      navigatorTitle("Help", false),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      size: 30,
                    ),
                    Text("Logout", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,

                    ),)
                  ],
                ),
              ),
              Container(

              )
            ],
          ),
        ],
      ),
    );
  }
  Row navigatorTitle(String name, bool isSelected){
    return Row(
      children: [
        (isSelected) ?
        Container(
          width: 5,
          height: 60,
          color: Color(0xffffac30),
        ) :
        Container(
          width: 5,
          height: 60,
        ),
        SizedBox(width: 10,height: 60,),
        Text(name, style: TextStyle(
          fontSize: 16,
          fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400,
        ),)
      ],
    );
  }
}





