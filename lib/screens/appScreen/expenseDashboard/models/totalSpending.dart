
import 'package:ewall/screens/appScreen/expenseDashboard/classes/circularData.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/CircularChart.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/LineChart.dart';
import 'package:flutter/material.dart';
import '../classes/SpendingData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class TotalSpending extends StatefulWidget {
  final String uid;
  const TotalSpending({Key key,this.uid}) : super(key: key);

  @override
  _TotalSpendingState createState() => _TotalSpendingState();
}

class _TotalSpendingState extends State<TotalSpending> {

  List<SpendingData> data = [];
  List<CircularData> others = [];

  @override
  void initState() {
    super.initState();
    getTSGraphData();
    getCCGraphData();
  }

  void getTSGraphData(){

    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid).
        collection('Transaction').orderBy('TransactionDate');
    collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        SpendingData tsd = SpendingData(
            DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch)
            ,element['TransactionAmount'].toDouble()
        );
        print(DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch).toString()
            +element['TransactionAmount'].toDouble().toString());
        setState(() {
          data.add(tsd);
        });
      }
      );});

  }

  void getCCGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid)
        .collection('Transaction');
    double TotalAmount=0;
    collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          TotalAmount = TotalAmount + element['TransactionAmount'];
        });
      }
      );
    }
    );


    var query1 = collectionReference.where('TransactionCategory',isEqualTo:"Entertainment");
    query1.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
          amount = amount + element['TransactionAmount'];
      }
      );
      setState(() {
        others.add(CircularData('Entertainment',((amount/TotalAmount)*100).toInt(),Colors.white));
      });
    }
    );

    var query2 = collectionReference.where('TransactionCategory',isEqualTo:"Food & Drinks");
    query2.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
          amount = amount + element['TransactionAmount'];
      }
      );
      setState(() {
        others.add(CircularData('Food & Drinks',((amount/TotalAmount)*100).toInt(),Colors.purple));
      });
    }
    );

    var query3 = collectionReference.where('TransactionCategory',isEqualTo:"Housing");
    query3.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Housing',((amount/TotalAmount)*100).toInt(),Colors.blue));
      });
    }
    );


    var query4 = collectionReference.where('TransactionCategory',isEqualTo:"Transportation");
    query4.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Transportation',((amount/TotalAmount)*100).toInt(),Colors.green));
      });
    }
    );

    var query5 = collectionReference.where('TransactionCategory',isEqualTo:"Investments");
    query5.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Investments',((amount/TotalAmount)*100).toInt(),Colors.lightGreenAccent));
      });
    }
    );

    var query6 = collectionReference.where('TransactionCategory',isEqualTo:"Income");
    query6.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Income',((amount/TotalAmount)*100).toInt(),Colors.brown));
      });

    }
    );

    var query7 = collectionReference.where('TransactionCategory',isEqualTo:"Insurance");
    query7.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Insurance',((amount/TotalAmount)*100).toInt(),Colors.yellow));
      });

    }
    );

    var query8 = collectionReference.where('TransactionCategory',isEqualTo:"Others");
    query8.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Others',((amount/TotalAmount)*100).toInt(),Colors.blueGrey));
      });

    }
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children : [
              SizedBox(height: 25,),
              Column(
                  children : [
                    Text("Your Date-Wise Expense",style: TextStyle(
                      fontSize: 18
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      height: 310,
                      child: LineChart(data: data),
                    ),
                    SizedBox(height: 20,),
                    Text("Category Wise Expense Percentage",style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      height: 308,
                      child: CircularChart(data : others),
                    ),
                  ]
              )
              ]
        )
        ),
      ),
    );
  }
}
