import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../sideMenu.dart';

class MyBudget extends StatefulWidget {
  final User user;
  const MyBudget({Key key, this.user}) : super(key: key);

  @override
  _MyBudgetState createState() => _MyBudgetState();
}

class _MyBudgetState extends State<MyBudget> {
  TextEditingController _limitamountcontroller = new TextEditingController();
  String _chosenMonth;
  String _chosenCategory;
  List category = [
    'Food/Drinks'
        'Education',
    'Entertainment',
    'Transportation',
    'Regular Expense',
    'House/Rent',
    'Health Care',
    'Dues/Subscriptions',
    'Savings/Investments',
    'Others'
  ];

  final GlobalKey<FormState> _limitformKey = GlobalKey<FormState>();

  void addBudget() {
    setState(() {
      int value = 0;
      switch (_chosenMonth.toString()) {
        case "January":
          {
            value = 1;
          }
          break;
        case "February":
          {
            value = 2;
          }
          break;
        case "March":
          {
            value = 3;
          }
          break;
        case "April":
          {
            value = 4;
          }
          break;
        case "May":
          {
            value = 5;
          }
          break;
        case "June":
          {
            value = 6;
          }
          break;
        case "July":
          {
            value = 7;
          }
          break;
        case "August":
          {
            value = 8;
          }
          break;
        case "September":
          {
            value = 9;
          }
          break;
        case "October":
          {
            value = 10;
          }
          break;
        case "November":
          {
            value = 11;
          }
          break;
        default:
          {
            value = 12;
          }
          break;
      }

      Map<String, dynamic> budgettxn = {
        'BudgetMonth': (_chosenMonth.toString()),
        'BudgetCategory': (_chosenCategory.toString()),
        'BudgetAmount': (_limitamountcontroller.text),
        'BudgetMonthNumber': value
      };
      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.user.uid)
          .collection("Budget")
          .add(budgettxn);
    });
  }

  Icon runtimeIcon(String category) {
    if (category == 'Entertainment') {
      return Icon(
        Icons.live_tv,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Food/Drinks') {
      return Icon(
        Icons.fastfood,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Education') {
      return Icon(
        Icons.account_balance_outlined,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Daily Expense') {
      return Icon(
        Icons.today,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Dues/Subscriptions') {
      return Icon(
        Icons.circle_notifications,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'House/Rent') {
      return Icon(
        Icons.house_outlined,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Transportation') {
      return Icon(
        Icons.emoji_transportation_outlined,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Savings/Investments') {
      return Icon(
        Icons.book_outlined,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Salary/BusinessIncome') {
      return Icon(
        Icons.attach_money_outlined,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Health Care') {
      return Icon(
        Icons.medical_services_outlined,
        color: Colors.white,
        size: 40.00,
      );
    } else {
      return Icon(
        Icons.category_rounded,
        color: Colors.white,
        size: 40.00,
      );
    }
  }

  Card makeCard(String category,String month,String amount) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      margin: new EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xfff53803),
                Color(0xfff5d020),
              ],
            ),
            borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  children: [
                    Text(
                      "Bussiness",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    "December",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ])
              ]),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Money Spent",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "100000",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Target",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "100000",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Remaining",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "100000",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    // tag: 'hero',
                    child: SfLinearGauge(
                      ranges: <LinearGaugeRange>[
                        //First range
                        LinearGaugeRange(
                            startValue: 0, endValue: 50, color: Colors.green),
                        LinearGaugeRange(
                            startValue: 50, endValue: 80, color: Colors.yellow),
                        LinearGaugeRange(
                            startValue: 80, endValue: 100, color: Colors.red),
                      ],
                      markerPointers: [
                        LinearShapePointer(value: 50),
                      ],
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container addLimit() {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _limitformKey,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange.shade600),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
              child: DropdownButton<String>(
                value: _chosenMonth,
                elevation: 5,
                style: TextStyle(color: Color(0xffEA6700)),
                items: <String>[
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Choose Your Budget Month",
                  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (String value) {
                  setState(() {
                    _chosenMonth = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange.shade600),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
              child: DropdownButton<String>(
                value: _chosenCategory,
                //elevation: 5,
                style: TextStyle(
                  color: Colors.black,
                ),

                items: <String>[
                  'Food/Drinks',
                  'Education',
                  'Entertainment',
                  'Transportation',
                  'Daily Expense',
                  'House/Rent',
                  'Health Care',
                  'Dues/Subscriptions',
                  'Savings/Investments',
                  'Others'
                ].map<DropdownMenuItem<String>>((String vvalue) {
                  return DropdownMenuItem<String>(
                    value: vvalue,
                    child: Text(vvalue),
                  );
                }).toList(),
                hint: Text(
                  "Choose a Budget Category",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (String vvalue) {
                  setState(() {
                    _chosenCategory = vvalue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.78,
              child: TextFormField(
                controller: _limitamountcontroller,
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
                    return 'Please Enter Budget Amount';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {},
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
                  margin: EdgeInsets.all(3),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.78,
                      minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(
                            'Create Your Budget',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          textColor: Colors.white,
                          onPressed: () {
                            if (_limitformKey.currentState.validate()) {
                              addBudget();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyBudget(
                                            user: widget.user,
                                          )));
                            }
                          },
                        ),
                      ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(user: widget.user),
      appBar: AppBar(
        title: Text("Your Budget"),
        backgroundColor: Color(0xfff53803),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create Your Budget",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
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
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: EdgeInsets.all(8),
                      child: addLimit(),
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
                    'Your Budget Limits',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(0),
                child: Row(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(widget.user.uid)
                          .collection('Budget')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('No Data Available'),
                          );
                        }
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.83,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            //color: Color(0xfff1f3f6),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot txndata = snapshot.data.docs[index];
                              return makeCard(txndata['BudgetCategory'],txndata['BudgetMonth'],txndata['BudgetAmount']);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
