
import 'package:ewall/screens/appScreen/expenseDashboard/classes/AreaChartData.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/classes/circularData.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/CircularChart.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/LineChart.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/RadialGauge.dart';
import 'package:ewall/screens/appScreen/expenseDashboard/models/StackedAreaChart.dart';
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

  List<LinearChartData> data = [];
  List<CircularData> others = [];
  List<AreaChartData> incomedata = [];
  var myGaugeAmountSpent = {
    "Food Items":0.0,
    "Education":0.0,
    "Entertainment":0.0,
    "Transportation":0.0,
    "Daily Expense":0.0,
    "House Rent":0.0,
    "Health Care":0.0,
    "Dues Subscriptions":0.0,
    "Savings Investments":0.0,
    "Others":0.0,
  };

  var myGaugeAmountLimit = {
    "Food Items":0.0,
    "Education":0.0,
    "Entertainment":0.0,
    "Transportation":0.0,
    "Daily Expense":0.0,
    "House Rent":0.0,
    "Health Care":0.0,
    "Dues Subscriptions":0.0,
    "Savings Investments":0.0,
    "Others":0.0,
  };

  var myGaugeAmountPercentage = {
    "Food Items":0.0,
    "Education":0.0,
    "Entertainment":0.0,
    "Transportation":0.0,
    "Daily Expense":0.0,
    "House Rent":0.0,
    "Health Care":0.0,
    "Dues Subscriptions":0.0,
    "Savings Investments":0.0,
    "Others":0.0,
  };


  @override
  void initState() {
    super.initState();
    getTSGraphData();
    getCCGraphData();
    getIncomeGraphData();
    getRGData('Food Items');
    getRGData('Education');
    getRGData('Entertainment');
    getRGData('Transportation');
    getRGData('Daily Expense');
    getRGData('House Rent');
    getRGData('Health Care');
    getRGData('Dues Subscriptions');
    getRGData('Savings Investments');
    getRGData('Others');
  }

  void getTSGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid).
    collection('Transaction').orderBy('TransactionDate');
    var query = collectionReference.where('KindOfTransaction',isEqualTo:"Expense");
    query.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        LinearChartData tsd = LinearChartData(
            DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch)
            ,element['TransactionAmount'].toDouble()
        );
        print("Total Spending Data");
        print(DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch).toString()
            +element['TransactionAmount'].toDouble().toString());
        setState(() {
          data.add(tsd);
        });
      }
      );});
  }

  void getIncomeGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid).
        collection('Transaction').orderBy('TransactionDate');
    collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if(element['KindOfTransaction']=='Income'){
        AreaChartData tsd = AreaChartData(
            date:DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch),
            incomeAmount:element['TransactionAmount'].toDouble()
        );
        setState(() {
          incomedata.add(tsd);
        });
        }else{
          AreaChartData tsd = AreaChartData(
              date:DateTime.fromMicrosecondsSinceEpoch(element['TransactionDate'].microsecondsSinceEpoch),
              expenseAmount:element['TransactionAmount'].toDouble()
          );
          setState(() {
            incomedata.add(tsd);
          });
        }
      }
      );});

  }

  void getCCGraphData(){
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid)
        .collection('Transaction');
    double totalAmount=0;
    collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          totalAmount = totalAmount + element['TransactionAmount'];
        });
      }
      );
    }
    );


    var query1 = collectionReference.where('TransactionCategory',isEqualTo:"Food Items");
    query1.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
          amount = amount + element['TransactionAmount'];
      }
      );
      setState(() {
        others.add(CircularData('Food Items',((amount/totalAmount)*100).toInt(),Color(0xff003F5C)));
      });
    }
    );

    var query2 = collectionReference.where('TransactionCategory',isEqualTo:"Education");
    query2.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
          amount = amount + element['TransactionAmount'];
      }
      );
      setState(() {
        others.add(CircularData('Education',((amount/totalAmount)*100).toInt(),Color(0xff58508D)));
      });
    }
    );

    var query3 = collectionReference.where('TransactionCategory',isEqualTo:"Entertainment");
    query3.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Entertainment',((amount/totalAmount)*100).toInt(),Color(0xffBC5090)));
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
        others.add(CircularData('Transportation',((amount/totalAmount)*100).toInt(),Color(0xffFF6361)));
      });
    }
    );

    var query5 = collectionReference.where('TransactionCategory',isEqualTo:"Daily Expense");
    query5.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Daily Expense',((amount/totalAmount)*100).toInt(),Color(0xffFFA600)));
      });
    }
    );

    var query6 = collectionReference.where('TransactionCategory',isEqualTo:"House Rent");
    query6.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('House Rent',((amount/totalAmount)*100).toInt(),Color(0xff93F03B)));
      });

    }
    );

    var query7 = collectionReference.where('TransactionCategory',isEqualTo:"Health Care");
    query7.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Health Care',((amount/totalAmount)*100).toInt(),Color(0xff9552EA)));
      });

    }
    );

    var query8 = collectionReference.where('TransactionCategory',isEqualTo:"Dues Subscriptions");
    query8.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Dues Subscriptions',((amount/totalAmount)*100).toInt(),Color(0xff378AFF)));
      });

    }
    );

    var query9 = collectionReference.where('TransactionCategory',isEqualTo:"Savings Investments");
    query9.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Savings Investments',((amount/totalAmount)*100).toInt(),Color(0xffFE8B02)));
      });

    }
    );

    var query10 = collectionReference.where('TransactionCategory',isEqualTo:"Others");
    query10.get().then((QuerySnapshot querySnapshot) {
      double amount=0;
      querySnapshot.docs.forEach((element) {
        setState(() {
          amount = amount + element['TransactionAmount'];
        });
      }
      );
      setState(() {
        others.add(CircularData('Others',((amount/totalAmount)*100).toInt(),Color(0xff9D0BFA)));
      });

    }
    );


  }

  void getRGData(String category) async{
    print("Category is "+category);
    double amountSpent=0;
    var collectionReference = FirebaseFirestore.instance.collection("Users").doc(widget.uid)
        .collection('Transaction');
    var query = collectionReference.where('TransactionCategory',isEqualTo:category);
    await query.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        amountSpent=amountSpent+element['TransactionAmount'];
      }
      );
      setState(() {
        myGaugeAmountSpent[category]=amountSpent;
        print("Amoutn spent gauge is :"+myGaugeAmountSpent[category].toString());
      });

    }
    );
    print("Amount Spent is "+amountSpent.toString());
    var collectionref = FirebaseFirestore.instance.collection("Users").doc(widget.uid)
        .collection('Budget');
    var bquery = collectionref.where('BudgetCategory',isEqualTo:category);
    await bquery.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          myGaugeAmountLimit[category]=double.parse(element['BudgetAmount']);
          print("limits gauge "+myGaugeAmountLimit[category].toString());
        });
      }
      );
    }
    );
    setState(() {
      if(myGaugeAmountSpent[category]==0){
        myGaugeAmountPercentage[category]=0.0;
      }else{
        if(myGaugeAmountLimit[category]==0){
          myGaugeAmountPercentage[category]=0.0;
        }else {
          myGaugeAmountPercentage[category] =
              (myGaugeAmountSpent[category]) / myGaugeAmountLimit[category] *
                  100;
          print("perce gauge " + myGaugeAmountPercentage[category].toString());
        }
      }

    });
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
                      height: MediaQuery.of(context).size.height*0.5,
                      child: LineChart(data: data),
                    ),
                    SizedBox(height: 20,),
                    Text("Category Wise Expense Percentage",style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.455,
                      child: CircularChart(data : others),
                    ),
                    SizedBox(height: 20,),
                    Text("Income Vs Expense Graph",style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: AreaChart(data: incomedata,),
                    ),
                    SizedBox(height: 20,),
                    Text("Your Limits Graph",style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Food Items',value: myGaugeAmountPercentage['Food Items'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Education',value: myGaugeAmountPercentage['Education'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Entertainment',value: myGaugeAmountPercentage['Entertainment'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Transportation',value: myGaugeAmountPercentage['Transportation'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Daily Expense',value: myGaugeAmountPercentage['Daily Expense'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'House Rent',value: myGaugeAmountPercentage['House Rent'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Health Care',value: myGaugeAmountPercentage['Health Care'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Dues Subscriptions',value: myGaugeAmountPercentage['Dues Subscriptions'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Savings Investments',value: myGaugeAmountPercentage['Savings Investments'],),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.53,
                      child: RadialChart(title: 'Others',value: myGaugeAmountPercentage['Others'],),
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
