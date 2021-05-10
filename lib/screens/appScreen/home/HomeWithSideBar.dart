import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class HomeWithSideBar extends StatelessWidget {
  //Variable declared for route to this HomePage
  static const routeName = '/home_page';
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

class _HomeWithSidebarState extends State<HomeWithSidebar> with TickerProviderStateMixin {
  //Variable to check whether menu is open or not
  bool sideBarActive = false;

  //var for animation Controller
  AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
  }

  //Main Logic of this Screen
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
                  /*This Container for that Big One
                    Rounded container in which user name & image will be displayed */
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
                      color: Colors.white,
                    ),

                    //In Center of this Container we placed Our name & Image
                    child: Center(

                      //Used Row For This display Purpose
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          //This Container to Display the Image of current user
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

                          //Column To Display Text Which is Name of User
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text for Current User Name
                              Text("Vishwajeet Behera", style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),),

                              //Text For Current User Location
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

              //This Expanded Widget for the menu which have our custom method navigatorTitle
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

              //This Container for The Logout Button
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    //Logout Icon Used
                    Icon(
                      Icons.power_settings_new,
                      size: 30,
                    ),

                    //Text Widget For The Logout Text
                    Text("Logout", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,

                    ),)
                  ],
                ),
              ),

              //This Container Used for Writing the Current version Number of Application
              Container(
              alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(20),
                child: Text("version 1.0.0", style: TextStyle(
                  color: Colors.grey,
                ),),
              )
            ],
          ),

          //Animation For showing the animation
          AnimatedPositioned(
            //Time duration of the animation
            duration: Duration(milliseconds: 200),
              //This to specify the Size of the Container from left
              left: (sideBarActive) ? MediaQuery.of(context).size.width*0.6 : 0,

              //This to specify the Size of the Container from left
              top: (sideBarActive) ? MediaQuery.of(context).size.height*0.2 : 0,

            //This to specify the rotation time
            child: RotationTransition(
              //This is for turning
              turns: (sideBarActive) ? Tween(begin: -0.05, end: 0.0).animate(rotationController) : Tween(begin: 0.0, end: -0.05).animate(rotationController) ,

              //This is to make the animated controller
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),

                //This is to specify the height and width of animated container
                height: (sideBarActive) ? MediaQuery.of(context).size.height*0.8 : MediaQuery.of(context).size.height,
                width: (sideBarActive) ? MediaQuery.of(context).size.width*0.8 : MediaQuery.of(context).size.width,

                //This is to change the border of container to circular
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.white
                ),

                //This is the main method which changes the page when menu item selected
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  //Here By Default Homepage Selected
                  child: HomePage(),
                ),
              ),
            )
          ),

          //This is to position the close button
          Positioned(
            right: 0,
            top: 20,
            //This is, if sidebar(Menu) is open then display this close sign else show open menu icon
            child: (sideBarActive) ? IconButton(
              padding: EdgeInsets.all(30),

              /*When pressed it will make sideBar(Menu) false
                Which invoke setState Method again
                which rebuild the HemeScreen
              */
              onPressed: closeSideBar,

              icon: Icon(
                Icons.close,
                color: Colors.black,
                size: 30,
              ),
            ) : InkWell(

              /*When pressed it will make sideBar(Menu) true
                Which invoke setState Method again
                which which open the menu
              */
              onTap: openSideBar,

              child: Container(
                margin: EdgeInsets.all(17),
                height: 30,
                width: 30,
                decoration: BoxDecoration(

                  //Here used the Menu Image to display the menu icon
                  image: DecorationImage(
                    image: AssetImage('asset/images/menu.png')
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //This is navigator tile to make menu
  Row navigatorTitle(String name, bool isSelected){
    return Row(
      //Here used children widget for selecting the menu
      children: [
        (isSelected) ?
        Container(
          width: 5,
          height: 60,
          //If the menu item is selected it will show side colour on it as it is selected
          color: Color(0xffffac30),
        ) :
        Container(
          width: 5,
          height: 60,
        ),
        SizedBox(width: 10,height: 60,),

        //This text to display the text of menu Items
        Text(name, style: TextStyle(
          fontSize: 16,

          //In This we are changing the boldness of selected menu item
          fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400,
        ),)
      ],
    );
  }

  //Method for closing the menu
  void closeSideBar(){
    sideBarActive = false;
    setState(() {

    });
  }

  //Method for opening the menu
  void openSideBar(){
    sideBarActive = true;
    setState(() {

    });
  }
}





