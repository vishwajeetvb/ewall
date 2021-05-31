
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class SendMoney extends StatefulWidget {

  const SendMoney({Key key}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {

  Razorpay razorpay;
  TextEditingController amount = new TextEditingController();

  @override
  void initState() {

    super.initState();

    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() async{
    var options={
      "key" : "rzp_test_I0fOIyFEryKsAi",
      "amount" : amount.text,
      "name" : "Ewall",
      "description" : "Paying To The User",
      "prefill" : {
        "contact" : "8059900797",
        "email" : "vishwajeetbehera0@gmail.com",
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);
    }catch(e){
      debugPrint(e);
    }
  }

  void handlerPaymentSuccess(){
    Toast.show("Payment Success", context);
  }

  void handlerErrorFailure(){
    Toast.show("Payment Error", context);
  }

  void handlerExternalWallet(){
    Toast.show("External Wallet", context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Send Money'),
        ),
        body: Center(
          child: Container(
            //height: MediaQuery.of(context).size.height*0.15,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center ,//Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  TextField(
                    controller: amount,
                    decoration: InputDecoration(
                      hintText: "Amount You Wish To Pay"
                    ),
                  ),
                  SizedBox(height: 12,),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: (){
                      openCheckout();
                    },
                    child: Text('Pay Now', style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ],
              ),
          ),
        ),
      );
  }
}
