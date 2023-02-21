

import 'dart:math';

class CalculatorBrain{
  CalculatorBrain({ required this.weight, required this.height});

  final int height;
  final int weight;
  //use the late keyword which will tell Dart that you are going to initialize the variable later
  late double _bmi;

  String calculateBMI(){
    _bmi=weight/pow(height/100, 2);
    //convert it to single decimal point value and return it as string
    return _bmi.toStringAsFixed(1);
  }

  String getResult(){
    if(_bmi>=25){
      return 'Over weight';
    }else if(_bmi>18.5){
      return 'Normal';
    }else{
      return 'Underweight';
    }
  }

  String getInterpretayion(){
    if(_bmi>=25){
      return "You have a higher than normal body weight .try to exercise more";
    }else if(_bmi>=18.5){
      return 'you have a normal body';
    }else {
      return 'You have a lower than normal body weight';
    }
  }

}