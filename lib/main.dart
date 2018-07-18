import 'package:flutter/material.dart';
import 'bmi_ui/bmi_ui.dart';

void main(){
  runApp(new MaterialApp(
    title: "BMI",
    theme:  new ThemeData(
          primaryColor: Colors.purpleAccent,
          accentColor: Colors.purple,

      ),
    debugShowCheckedModeBanner: false,
    home: new BmiUi(),
  ));
}