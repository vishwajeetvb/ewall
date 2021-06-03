import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../sideMenu.dart';

class MyBudget extends StatefulWidget {
  final User user;
  const MyBudget({Key key, this.user}) : super(key: key);

  @override
  _MyBudgetState createState() => _MyBudgetState();
}

class _MyBudgetState extends State<MyBudget> {
  TextEditingController _limitamountcontroller = new TextEditingController();
  String _chosenCategory;


  final GlobalKey<FormState> _limitformKey = GlobalKey<FormState>();

  void addBudget() {
    setState(() {
      Map<String, dynamic> budgettxn = {
        'BudgetCategory': (_chosenCategory.toString()),
        'BudgetAmount': (_limitamountcontroller.text),
      };

      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.user.uid)
          .collection("Budget").doc(_chosenCategory)
          .set(budgettxn);
    });
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
                  'Food Items',
                  'Education',
                  'Entertainment',
                  'Transportation',
                  'Daily Expense',
                  'House Rent',
                  'Health Care',
                  'Dues Subscriptions',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Limits",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "To Your Desired Category",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir',
                    ),
                  ),
                ],
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

            ],
          ),
        ),
      ),
    );
  }
}
