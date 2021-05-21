import 'package:ewall/screens/appScreen/home/SendMoney.dart';
import 'package:ewall/screens/appScreen/sideMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget  {
  static const routeName = '/home';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> addTransactions(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(15),
              content: Container(
                width: double.minPositive,
                child: Container(
                  width: double.minPositive,
                  height: 150,
                  child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          appBar: PreferredSize(
                            preferredSize: Size.fromHeight(48),
                            child: AppBar(
                              backgroundColor: Colors.orange,
                              bottom: TabBar(
                                  tabs: <Widget>[
                                      Tab(
                                        child :Text('Income',style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800
                                        ),),
                                      ),
                                      Tab(
                                        child :Text('Spending',style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w800
                                        ),),
                                      ),
                                    ]
                              ),
                            ),
                          ),
                          body: TabBarView(
                            children: <Widget>[
                              Center(
                                child: Text("Income"),
                              ),
                              Center(
                                child: Text("Settings"),
                              )
                            ],
                            controller: _tabController,
                          ),
                        ),
                      ),
                      color: Colors.white,
                    ),
                ),
              ),
              actions: <Widget>[
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent
                      ),
                      child : InkWell(
                        child: Text('Close'),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    
                    SizedBox(width: 250,),
                    InkWell(
                      child: Text('OK'),
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          // Do something like updating SharedPreferences or User Settings etc.
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                )

              ],
            );
          });
        });
  }


  //Main Logic of Home Page
  @override
  Widget build(BuildContext context) {
    //This Scaffold for next screen after clicking on sign in
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('TransManager'),
        backgroundColor: Color(0xffffac30),
      ),
      //This will set screen full white
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
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
                        height: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('asset/images/logo.png'),
                        )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      //This Text will display eWall
                      Text(
                        "TransManager",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'ubuntu',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Send Money",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
                    ),
                  ),

                  //Button for Navigating to the next page for sending Money
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SendMoney()));
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black87,
                      size: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //This Row for Send Money and Send Money Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Account",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
                    ),
                  ),

                  //Button for Navigating to the next page for sending Money
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SendMoney()));
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black87,
                      size: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //This container for that whole white box and icon
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Container(
                      child: addAccount(15000, 'Paytm Payments Bank'),
                    ),
                    Container(
                      child: addAccount(2000, 'Kotak Mahindra Bank'),
                    ),
                    Container(
                      child: addAccount(5989, 'Axis Bank'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Transactions',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    child: IconButton(
                      onPressed: () async {
                          await addTransactions(context);
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.black87,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(0.5),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      height: MediaQuery.of(context).size.height*0.3,
                      width: 294,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xfff1f3f6),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }



  Container addAccount(var money, String bankName) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xfff1f3f6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xfff1f3f6),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //This Column for that white space to show balance
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$money',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '$bankName',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
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
          )
        ],
      ),
    );
  }

  //Our serviceWidget
  Column serviceWidget(String img, String name) {
    return Column(
      children: [
        Expanded(
            child: InkWell(
          onTap: () {},
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
                )),
              ),
            ),
          ),
        )),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'avenir',
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
