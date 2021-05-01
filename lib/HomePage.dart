
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    //This Scaffold for next screen after clicking on sign in
    return Scaffold(
      //This will set screen full white
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //This is the top row of screen
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('asset/images/logo.png'),
                        )
                      ),
                    ),
                    SizedBox(width: 5,),
                    //This Text will display eWall
                    Text("eWall",style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'ubuntu',
                      fontSize: 25
                    ),),
                  ],
                ),
                ],
            ),
                SizedBox(height: 20,),
                Text("Account Overview",style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'avenir',
                ),),
                SizedBox(height: 10,),
                //This container for that whole white box and icon
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xfff1f3f6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //This Column for that white space to show balance
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("20,600",style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),),
                          SizedBox(height: 5,),
                          Text("Current Balance", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),)
                        ],
                      ),
                      //This column for that icon
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffffac30),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                //This Row for Send Money and Scanqr icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Send Money", style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
                    ),),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('asset/images/scanqr.png'),
                        )
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffffac30),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                      avatarWidget("avatar1","Mike"),
                      avatarWidget("avatar2","Joseph"),
                      avatarWidget("avatar3","Ashley"),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Services', style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
                    ),),
                    Container(
                      height: 60,
                      width: 60,
                      child: Icon(Icons.dialpad),
                    )
                  ],
                ),
                Expanded(
                    child: GridView.count(crossAxisCount: 4,
                    childAspectRatio: 0.7,
                      children: [
                        serviceWidget("sendMoney","Send\nMoney"),
                        serviceWidget("receiveMoney","Receive\nMoney"),
                        serviceWidget("phone","Mobile\nRecharge"),
                        serviceWidget("electricity","Electricity\nBill"),
                        serviceWidget("tag","Cashback\nOffer"),
                        serviceWidget("flight","Flight\nTicket"),
                        serviceWidget("more","More\n"),
                      ],
                    ))
              ],
        ),
      ),
    );
  }
  //Our sericeWidget
  Column serviceWidget(String img, String name){
       return Column(
         children: [
           Expanded(
               child: InkWell(
                 onTap: (){},
                 child: Container(
                   margin: EdgeInsets.all(4),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                     color: Color(0xfff1f3f6),
                   ),
                   child: Center(
                     child: Container(
                       margin: EdgeInsets.all(25),
                       decoration: BoxDecoration(
                         image: DecorationImage(
                           image: AssetImage('asset/images/$img.png'),
                         )
                       ),
                     ),
                   ),
                 ),
               )),
           SizedBox(height: 5,),
           Text(name, style: TextStyle(
             fontFamily: 'avenir',
             fontSize: 14,
           ),
             textAlign: TextAlign.center,
           )
         ],
       );
  }
  //Our avatarWidget Method
  Container avatarWidget(String img, String name){
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 150,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xfff1f3f6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('asset/images/$img.png'),
                fit: BoxFit.contain,
              ),
              border: Border.all(
                color: Colors.black,
                width: 2,
              )
            ),
          ),
          Text(name, style: TextStyle(
            fontSize: 16,
            fontFamily: 'avenir',
            fontWeight: FontWeight.w700
          ),)
        ],
      ),
    );
  }
}

