import 'package:flutter/material.dart';
import 'package:minapp/minapp.dart' as BaaS;
import './pages/home.dart';


void main()  {
  BaaS.init('3a6403817e8e857cc316');
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: HomePage(),
    );
  }
}