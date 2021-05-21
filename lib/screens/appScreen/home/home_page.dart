import 'package:ewall/screens/appScreen/home/SendMoney.dart';
import 'package:ewall/screens/appScreen/sideMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';


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

  final TextEditingController _amountController = TextEditingController();

  final dateController = TextEditingController();

  String _chosenCategory;
  bool kindOfTransaction = false;
  bool transactionClass = false;

  Future<void> addTransactions(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.all(Radius.circular(30))),

              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 411,
                   child: Form(
                     key: _formKey,
                     child: Column(
                       children: [
                         //TextFormField For Amount
                         TextFormField(
                           controller: _amountController,
                           cursorColor: Colors.orange,
                           decoration: InputDecoration(
                             labelText: "Enter Transaction Amount",
                             border: new OutlineInputBorder(
                               borderRadius: new BorderRadius.circular(25.0),
                             ),
                           ),
                           // The validator receives the text that the user has entered.
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter Amount';
                             }
                             return null;
                           },
                         ),
                         SizedBox(height: 10,),
                         //This Container for choosing category of Transaction such assets, liabilities
                         Container(
                           decoration: BoxDecoration(
                             border: Border.all(
                               color: Colors.orange.shade600
                             ),
                             borderRadius: BorderRadius.circular(20)
                           ),
                           padding: const EdgeInsets.fromLTRB(40, 2, 40, 2),
                           child: DropdownButton<String>(
                             value: _chosenCategory,
                             elevation: 5,
                             style: TextStyle(color: Color(0xffEA6700)),

                             items: <String>[
                               'Entertainment',
                               'Food & Drinks',
                               'Housing',
                               'Transportation',
                               'Vehicle',
                               'Investments',
                               'Income',
                               'Insurance',
                               'Others'
                             ].map<DropdownMenuItem<String>>((String value) {
                               return DropdownMenuItem<String>(
                                 value: value,
                                 child: Text(value),
                               );
                             }).toList(),
                             hint: Text(
                               "Choose Category",
                               style: TextStyle(
                                   color: Colors.orangeAccent,
                                   fontSize: 16,
                                   fontWeight: FontWeight.w600),
                             ),
                             onChanged: (String value) {
                               setState(() {
                                 _chosenCategory = value;
                               });
                             },
                           ),
                         ),
                         SizedBox(height: 15,),
                         //This Container for Date Picking
                         Container(
                           child: TextField(
                           readOnly: true,
                           controller: dateController,
                           decoration: InputDecoration(
                               hintText: 'Pick Your Transaction Date',
                               border: new OutlineInputBorder(
                               borderRadius: new BorderRadius.circular(25.0),
                             )

                           ),
                           onTap: () async {
                             var date =  await showDatePicker(
                                 context: context,
                                 initialDate:DateTime.now(),
                                 firstDate:DateTime(1900),
                                 lastDate: DateTime(2100));
                             dateController.text = date.toString().substring(0,10);
                           },)),
                         SizedBox(height: 5,),
                         //This is For Choosing Transaction Kind as Income/Expense
                         Padding(
                           padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                           child: Text('Select Kind of Transaction ',
                               style:
                               TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                         ),
                         ToggleSwitch(
                             minWidth: 110.0,
                             cornerRadius: 20,
                             activeBgColor: Colors.orange,
                             inactiveBgColor: Colors.white,
                             labels: ['Income', 'Expense'],
                             onToggle: (index) {
                               if(index==0){
                                  kindOfTransaction=false;
                               }else{
                                 kindOfTransaction=true;
                               }
                             }),
                         SizedBox(height: 5,),
                         //This is for Choosing Transaction Class For Graph
                         Padding(
                           padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                           child: Text('Select Transaction Class ',
                               style:
                               TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                         ),
                         ToggleSwitch(
                             minWidth: 110.0,
                             cornerRadius: 20,
                             activeBgColor: Colors.orange,
                             inactiveBgColor: Colors.white,
                             labels: ['Assets', 'Liabilities'],
                             onToggle: (index) {
                               if(index==0){
                                  transactionClass=false;
                               }else{
                                 transactionClass=true;
                               }
                             }),
                       ],
                     ),
                   ),
                ),
              ),
              actions: <Widget>[
                Row(
                  children: [
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.all(6),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // Do something like updating SharedPreferences or User Settings etc.
                            Navigator.of(context).pop();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xffFFD169), Color(0xffEA6700)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Gradient Button",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
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
                    //To Conthe alert dialoug boxtrol height of
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
