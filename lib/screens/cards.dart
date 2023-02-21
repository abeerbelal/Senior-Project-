import 'package:flutter/material.dart';
import 'package:chat_test/screens/learnExercise/choose_exersice.dart';
import 'package:chat_test/screens/bmi/bmi_screen.dart';
import 'profil.dart';
import 'nutrition/screens_nutrition/home.dart';
import 'category_screen.dart';


class cards extends StatefulWidget {
  static const String id='Cards_screen';
  const cards({Key? key}) : super(key: key);

  @override
  State<cards> createState() => _cardsState();
}

class _cardsState extends State<cards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("choose what you want"),


      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 90,left: 10,right: 10,bottom: 10),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, CategoryScreen.id);
                },
                child: Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFe65c00)
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sports,
                      size: 50,
                      color: Colors.white,),
                      Text("Exersices",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white
                      ),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, nutrition_page.id);
                },
                child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.food_bank_outlined,
                        size: 50,
                        color: Colors.white,),
                      Text("Nutriton",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white
                        ),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Profile.id);
                },
                child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:Color(0xFFff8533)
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings,
                        size: 50,
                        color: Colors.white,),
                      Text("Settings",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white
                        ),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, BMICalculator.id);
                },
                child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:Colors.orangeAccent
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.text_snippet_outlined,
                        size: 50,
                        color: Colors.white,),
                      Text("BMI Test",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white
                        ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
