import 'package:flutter/material.dart';
import 'input_dart.dart';
class BMICalculator extends StatelessWidget {
  static const String id = 'bmi_screen';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.light().copyWith( // to use the primaryColor
          primary: Colors.orangeAccent,
        ),
        // primaryColor:Colors.red, this does not work
        accentColor: Colors.deepPurple,
        scaffoldBackgroundColor: Color(0xFFFFD580),
        // textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white),)
      ),
      home: InputPage(),
    );
  }
}