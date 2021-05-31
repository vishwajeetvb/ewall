import 'package:ewall/screens/appScreen/home/models/SendMoney.dart';
import 'package:ewall/screens/appScreen/home/classes/Transactions.dart';
import 'package:ewall/screens/appScreen/sideMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'classes/User.dart';

class Homepage extends StatefulWidget {
  static const routeName = '/home';
  Homepage({Key key,this.user}) : super(key: key);
  User user;
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CurrentUser currentUser;

  TextEditingController _transactionTitleController;
  TextEditingController _amountController;
  DateTime selectedData;
  String _chosenCategory;
  bool kindOfTransaction = false;
  bool transactionClass = false;

  TextEditingController _utransactionTitleController = TextEditingController();
  TextEditingController _uamountController = TextEditingController();
  DateTime uselectedData ;
  String _uchosenCategory;
  bool ukindOfTransaction ;
  int labelkot;
  int labelutc;
  bool utransactionClass;
  static double amountInAccount = 0;

  @override
  void initState() {
    super.initState();
    _transactionTitleController = TextEditingController();
    _amountController = TextEditingController();
    getAmountInAccount();
  }

  void getAmountInAccount(){
    amountInAccount=0;
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.user.uid)
        .collection('Transaction');
    var query = collectionReference.where('TransactionAmount',isGreaterThanOrEqualTo: 0);
    query.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          amountInAccount+=element['TransactionAmount'];
        });
      }
      );
      }
      );
  }

  //Function To Add Transaction To List
  void addTransactionsToList() {
    setState(() {
      Transactions tn = new Transactions();
      if (kindOfTransaction==false) {
        tn.kindOfTransaction = "Income";
      } else {
        tn.kindOfTransaction = "Expense";
      }
      if (transactionClass==false) {
        tn.transactionClass = "Assets";
      } else {
        tn.transactionClass = "Liabilities";
      }
      amountInAccount+=double.tryParse(_amountController.text);
      Map<String, dynamic> txn = {
        'TransactionTitle': (_transactionTitleController.text),
        'TransactionAmount': (int.parse(_amountController.text)),
        'TransactionCategory': (_chosenCategory.toString()),
        'TransactionDate': selectedData,
        'KindOfTransaction': tn.kindOfTransaction,
        'TransactionClass': tn.transactionClass,
      };
      FirebaseFirestore.instance.collection("Users").doc(widget.user.uid).collection("Transaction").add(txn);
    });
  }

  //Function to Dynamically change the icons based on Transaction Type
  Icon runtimeIcon(String category) {
    if (category == 'Entertainment') {
      return Icon(
        Icons.live_tv,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Food & Drinks') {
      return Icon(
        Icons.fastfood,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Housing') {
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
    } else if (category == 'Investments') {
      return Icon(
        Icons.book_outlined,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Income') {
      return Icon(
        Icons.money,
        color: Colors.white,
        size: 40.00,
      );
    } else if (category == 'Insurance') {
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

  //Function For Showing add transaction Dialogue
  Future<void> addTransactions(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 502,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //TextFormField For TransactionName
                        TextFormField(
                          controller: _transactionTitleController,
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            labelText: "Enter Transaction Name",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter A Title For Transaction';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

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
                        SizedBox(
                          height: 10,
                        ),

                        //This Container for choosing category of Transaction such assets, liabilities
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange.shade600),
                              borderRadius: BorderRadius.circular(20)),
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
                        SizedBox(
                          height: 15,
                        ),

                        //This Container for Date Picking
                        Container(
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Only Date',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              selectedData = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //This is For Choosing Transaction Kind as Income/Expense
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Text('Select Kind of Transaction ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                        ToggleSwitch(
                            minWidth: 110.0,
                            cornerRadius: 20,
                            activeBgColor: Colors.orange,
                            inactiveBgColor: Colors.white,
                            labels: ['Income', 'Expense'],
                            onToggle: (index) {
                              if (index == 0) {
                                kindOfTransaction = false;
                              } else {
                                kindOfTransaction = true;
                              }
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        //This is for Choosing Transaction Class For Graph
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Text('Select Transaction Class ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                        ToggleSwitch(
                            minWidth: 110.0,
                            cornerRadius: 20,
                            activeBgColor: Colors.orange,
                            inactiveBgColor: Colors.white,
                            labels: ['Assets', 'Liabilities'],
                            onToggle: (index) {
                              if (index == 0) {
                                transactionClass = false;
                              } else {
                                transactionClass = true;
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
                            addTransactionsToList();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Homepage(user: widget.user,)));
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
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Add Transactions",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
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

  //Delete Methods for Deleting Transactions
  Future<void> deleteTransaction(DocumentSnapshot txndoc) async {
    setState(() {
      FirebaseFirestore.instance.collection("Users").doc(widget.user.uid)
          .collection("Transaction").doc(txndoc.id)
          .delete();
      getAmountInAccount();
    });
  }

  Future<void> updateTransaction(DocumentSnapshot txndoc) async {
    setState(() {
      String kot;
      String tc;

      if(ukindOfTransaction==null){
        kot=txndoc['KindOfTransaction'];
      }
      else if(ukindOfTransaction==false){
        kot="Income";
      }else{
        kot="Expense";
      }

      if(utransactionClass==null){
        tc=txndoc['TransactionClass'];
      }
      else if(utransactionClass==false){
        tc="Assets";
      }else{
        tc="Liabilities";
      }

      print("kindot"+ukindOfTransaction.toString()+"tranc"+utransactionClass.toString());
      print("kindot"+kot+"tranc"+tc);


      FirebaseFirestore.instance.collection("Users").doc(widget.user.uid)
          .collection("Transaction").doc(txndoc.id)
          .update(
        {
          'TransactionTitle': (_utransactionTitleController.text),
          'TransactionAmount': (int.parse(_uamountController.text)),
          'TransactionCategory': (_uchosenCategory.toString()),
          'TransactionDate': uselectedData,
          'KindOfTransaction': kot,
          'TransactionClass': tc,}
      );
    });
  }
  void getupdateControllerValue(BuildContext context,DocumentSnapshot txndoc){
    _utransactionTitleController.text=txndoc['TransactionTitle'].toString();
    _uamountController.text=txndoc['TransactionAmount'].toString();
    uselectedData=DateTime.fromMicrosecondsSinceEpoch(txndoc['TransactionDate'].microsecondsSinceEpoch);
    _uchosenCategory=txndoc['TransactionCategory'];
    if(txndoc['KindOfTransaction']=="Income"){
      labelkot=0;
    }else{
      labelkot=1;
    }
    if(txndoc['TransactionClass']=="Assets"){
      labelutc=0;
    }else{
      labelutc=1;
    }
    updateTransactionsForm(context,txndoc);
  }
  Future<void> updateTransactionsForm(BuildContext context,DocumentSnapshot txndoc) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 502,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //TextFormField For TransactionName
                        TextFormField(
                          controller: _utransactionTitleController,
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            labelText: "Enter Transaction Name",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter A Title For Transaction';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //TextFormField For Amount
                        TextFormField(
                          controller: _uamountController,
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
                        SizedBox(
                          height: 10,
                        ),

                        //This Container for choosing category of Transaction such assets, liabilities
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange.shade600),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.fromLTRB(40, 2, 40, 2),
                          child: DropdownButton<String>(
                            value: _uchosenCategory,
                            elevation: 5,
                            style: TextStyle(color: Color(0xffEA6700)),
                            items: <String>[
                              'Entertainment',
                              'Food & Drinks',
                              'Housing',
                              'Transportation',
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
                                _uchosenCategory = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //This Container for Date Picking
                        Container(
                          child: DateTimeFormField(
                            initialValue: uselectedData,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Only Date',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              uselectedData = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //This is For Choosing Transaction Kind as Income/Expense
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Text('Select Kind of Transaction ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                        ToggleSwitch(
                          initialLabelIndex: labelkot,
                            minWidth: 110.0,
                            cornerRadius: 20,
                            activeBgColor: Colors.orange,
                            inactiveBgColor: Colors.white,
                            labels: ['Income', 'Expense'],
                            onToggle: (index) {
                              if (index == 0) {
                                ukindOfTransaction = false;
                              } else {
                                ukindOfTransaction = true;
                              }
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        //This is for Choosing Transaction Class For Graph
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Text('Select Transaction Class ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                        ToggleSwitch(
                          initialLabelIndex: labelutc,
                            minWidth: 110.0,
                            cornerRadius: 20,
                            activeBgColor: Colors.orange,
                            inactiveBgColor: Colors.white,
                            labels: ['Assets', 'Liabilities'],
                            onToggle: (index) {
                              if (index == 0) {
                                utransactionClass = false;
                              } else {
                                utransactionClass = true;
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
                            updateTransaction(txndoc);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Homepage()));
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
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Update Transactions",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
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

  Future<void> viewTransactions(BuildContext context,DocumentSnapshot txndoc)  async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 502,
                  child:
                    Column(
                      children: [

                        Row(
                          children: [
                            Container(
                              height: 50.0,
                              margin: EdgeInsets.all(6),
                              child: RaisedButton(
                                onPressed: () async{
                                    await deleteTransaction(txndoc);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Homepage()));
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
                                    margin: EdgeInsets.all(3),
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width*0.59, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Text(
                                          "Transaction Details",
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(color: Colors.white, fontSize: 15),
                                        ),
                                        SizedBox(width: 20),
                                        IconButton(
                                            onPressed: () {

                                            },
                                            icon: Icon(Icons.delete)
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                        SizedBox(height: 10,),

                       ],
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
                          getupdateControllerValue(context, txndoc);
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
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Update Transactions",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
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

    //Method Returning the card to make the tiles for list view
    Card makeCard(DocumentSnapshot txndata,String id,String title,String category,var amount,DateTime time){
        return Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          margin:
          new EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFFD169),
                      Color(0xffEA6700),
                    ],
                  ),
                  borderRadius:
                  BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 3, vertical: 7),
                //Container For The Icon
                leading: Container(

                    decoration: new BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(5)),
                    child: Container(
                        padding:
                        EdgeInsets.only(left: 10),
                        child: runtimeIcon(category))),
                //This title to Show Amount
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                //This is to show the Entertainment Row
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            width: 500,
                            // tag: 'hero',
                            child: Text(
                              "${time.year.toString()}"
                                  "-${time.month.toString()}"
                                  "-${time.day.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                  color:
                                  Colors.white),
                            ))),
                    SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 10.0),
                          child: Text(
                              '\u{20B9}${amount.toDouble()}',
                              style: TextStyle(
                                  color:
                                  Colors.white))),
                    )
                  ],
                ),
                trailing: Container(
                  width: 40,
                    child: IconButton(
                      onPressed: () async {
                        await viewTransactions(context,txndata);
                      },
                      icon: Icon(Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 30.0),
                    )
                ),
              )),
        );
    }

    //This Scaffold for next screen after clicking on sign in
    return Scaffold(
      drawer: SideDrawer(user:widget.user),
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
                    "Your Account",
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
                      child: addAccount(amountInAccount, 'Your Expense Amount'),
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
                padding: EdgeInsets.all(0),
                child: Row(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Users").doc(widget.user.uid)
                          .collection('Transaction')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('No Data Avaliable'),
                          );
                        }
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.83,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            //color: Color(0xfff1f3f6),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index){
                              DocumentSnapshot txndata = snapshot.data.docs[index];
                              return makeCard(txndata, txndata.id,
                                  txndata['TransactionTitle'], txndata['TransactionCategory'],
                                  txndata['TransactionAmount'],
                                  DateTime.fromMicrosecondsSinceEpoch(txndata['TransactionDate'].microsecondsSinceEpoch)
                              );
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

  //This Widget To Add Account
  Container addAccount(var money, String textName) {
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
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '$textName',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
                    child: IconButton(
                      onPressed: () async {
                        await addTransactions(context);
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                      ),
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
