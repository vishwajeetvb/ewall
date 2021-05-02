import 'package:flutter/material.dart';
import 'auth/auth.dart';

class MyLoginHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: AuthScreen(),
      );
  }
}
