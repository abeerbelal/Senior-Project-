import 'constant.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'reusable_Card.dart';
import 'botton_button.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({ required this.bmiResult,required this.interpretation,required this.resultsText});

  final String bmiResult;
  final String resultsText;
  final String interpretation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text("your result ",
                  style: kTitleTextStyle,
                ),
              )
          ),
          Expanded(
            flex: 5,
            child: ReuableCard(
              colur: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('Normal', insted of this we creat obj and ...
                  Text(resultsText.toUpperCase(),style: kResultTextStyle,
                  ),
                  Text(bmiResult,style: kBMITextStyle,
                  ),
                  Text(interpretation,style: kBodyTextStyle,
                    textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitlel: 'RE-CALCULATE',
            onTap: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
