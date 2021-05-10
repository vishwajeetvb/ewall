
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendMoney extends StatefulWidget {
  static const routeName = '/sendMoney';
  const SendMoney({Key key}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Money'),
      ),
      body: Center(
        child: Column(

        ),
      ),
    );
  }
}
