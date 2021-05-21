
import 'package:flutter/material.dart';
import 'filePicker.dart';

class UploadTransactions extends StatefulWidget {
  const UploadTransactions({Key key}) : super(key: key);

  @override
  _UploadTransactionsState createState() => _UploadTransactionsState();
}

class _UploadTransactionsState extends State<UploadTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Our Transactions'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: FilePickr()
      ),
    );
  }
}
