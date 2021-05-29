
import 'package:ewall/screens/appScreen/expenseDashboard/classes/circularData.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/CircularChart.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/LineChart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../classes/SpendingData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class TotalSpending extends StatefulWidget {
  const TotalSpending({Key key}) : super(key: key);

  @override
  _TotalSpendingState createState() => _TotalSpendingState();
}

class _TotalSpendingState extends State<TotalSpending> {

  //Here we make a reference to our collection Transactions
  CollectionReference users = FirebaseFirestore.instance.collection('Transactions');

  List<SpendingData> data = [];
  List<CircularData> others = [];

  @override
  void initState() {
    super.initState();
    getTSGraphData();
    print("This is list"+others.toString());
    getCCGraphData();
    print("This is list"+others.toString());

  }

  void getTSGraphData(){

    var collectionReference = FirebaseFirestore.instance.collection('Transactions').orderBy('TransactionDate');
    collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        SpendingData tsd = SpendingData(
            DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch)
            ,element['TransactionAmount'].toDouble()
        );
        setState(() {
          data.add(tsd);
        });
      }
      );});

  }

  void getCCGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection('Transactions');
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
    print("Total $TotalAmount");


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

    var query6 = collectionReference.where('TransactionCategory',isEqualTo:"Salary");
    query6.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Salary',((amount/TotalAmount)*100).toInt(),Colors.deepPurple));
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
                    Text("Your Date-Wise Expense"),
                    SizedBox(height: 10,),
                    Container(
                      color: Colors.purple,
                      height: 310,
                      child: LineChart(data: data),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      color: Colors.purple,
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
