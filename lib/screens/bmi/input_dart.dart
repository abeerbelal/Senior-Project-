import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_Content.dart';
import 'reusable_Card.dart';
import 'constant.dart';
import 'results_page.dart';
import 'botton_button.dart';
import 'calculator_brain.dart';



enum Gender{
  male,female
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height=180;
  int weight=60;
  int age=18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Row(
            children: <Widget>[
              Expanded(
                child: ReuableCard(
                  onPress: (){
                    setState(() {
                      selectedGender=Gender.male;
                    });
                  },
                  colur:selectedGender==Gender.male?kActiveCardColor:kInactiveCardColor,
                  cardChild: iconContent(
                    icon: FontAwesomeIcons.mars,
                    lable: "MALE",
                  ),),
              ),
              Expanded(

                child:
              ReuableCard(
                //befor of this step and passes th fun as parameter
                // the GestDet.. was a widget holds the Reusaable
                //check this code in history (in the comments below)

                onPress: (){
                  setState(() {
                    selectedGender=Gender.female;
                  });
                },
                colur:selectedGender==Gender.female?kActiveCardColor:kInactiveCardColor,
                cardChild: iconContent(
                  icon: FontAwesomeIcons.venus,
                  lable: "FEMALE",
                ),
              ),
              ),
            ],
          )),
          Expanded(child:
          ReuableCard(
            colur:kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("HEIGHT",style: kLableTextStyle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //this to make "cm" at the same height in the line with 180

                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  //and this text base because the line above run error without it
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(height.toString()
                      ,style: kNumTextStyle,
                    ),
                    Text("cm",style: kLableTextStyle,
                    )
                  ],
                ),
                SliderTheme(
                  //this context comes from above class which is
                  //the state of our app
                  //using of it is like i take a copy of what is look like as defult

                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor:Color(0xFF8D8E98) ,
                    //we put here only things i want to change
                    activeTrackColor: Colors.white,
                    thumbColor: Color(0xFFFF7518),
                    overlayColor: Color(0x29E85816),
                    thumbShape:
                    RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape:
                    RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(value: height.toDouble(),
                    onChanged: (double newValue){
                      setState(() {
                        height=newValue.round();

                      });
                      //  print(newValue);
                    },
                    activeColor: Colors.white,
                    // activeColor: Color(اللون الثابت الي بدي ياه ),
                    min: 120.0,
                    max: 220.0,
                  ),
                ),
              ],

            ),
          )
          ),
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child:
              ReuableCard(colur:kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("WEIGHT",style: kLableTextStyle,),

                      Text(weight.toString(),
                        style: kNumTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: Text('btn of weight')
                            ,onPressed: (){
                            setState(() {
                              weight++;
                            });
                          },
                            backgroundColor: Color(0xFF4CF5E),
                            child: Icon(Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10.0,
                          ),
                          RoundIconButton(
                            onPress: (){
                              setState(() {
                                weight--;
                              });
                            },
                            icon:FontAwesomeIcons.minus,
                          ),
                        ],
                      ),
                    ],
                  )
              ),
              ),
              Expanded(child:
              ReuableCard(colur:kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("AGE",style: kLableTextStyle,),

                    Text(age.toString(),
                      style: kNumTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(onPressed: (){
                          setState(() {
                            age++;
                          });
                        },
                          backgroundColor: Color(0xFF4CF5E),
                          child: Icon(Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.0,
                        ),
                        RoundIconButton(
                          onPress: (){
                            setState(() {
                              age--;
                            });
                          },
                          icon:FontAwesomeIcons.minus,
                        ),
                      ],
                    ),

                  ],
                ),



              )),
            ],
          )),
          BottomButton(
            buttonTitlel: 'CALCULATOR',onTap: (){
            CalculatorBrain calc=
            CalculatorBrain(weight:weight, height:height);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>ResultsPage(
                      bmiResult: calc.calculateBMI(),
                      resultsText: calc.getResult(),
                      interpretation: calc.getInterpretayion(),
                    )
                )
            );
          }
            ,),
        ],
      ),
    );
  }


}

// i can separate this like botton_button but i let it like that to know all ways
class RoundIconButton extends StatelessWidget {
  RoundIconButton({ required this.icon,  required this.onPress});
  // final Widget? child;
  final IconData? icon;
  final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      //child:child,
      child:Icon(icon) ,
      onPressed:onPress,
      elevation: 6.0//for shadow with==> onpress on
      ,constraints: BoxConstraints.tightFor(
      width: 56.0,
      height: 56.0,
    ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // shape: CircleBorder(),//i can choose any shape i want

      fillColor: Color(0xFF4CF5E),
    );
  }
}



