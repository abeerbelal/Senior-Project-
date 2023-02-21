import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final food;
  final String text;
  final String img;
  final String cal;
  final String pro;
  final String cals;


  DetailPage({this.food,
    required this.text,
    required this.img,
    required this.cal,
    required this.cals,
    required this.pro
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
        title: Text(food[0]),

      ),
      body: SafeArea(
        child: Stack(
          children: [
            DelayedDisplay(
              delay: Duration(milliseconds: 100),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        color: Color(0xffcfdece),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30)
                        ),
                      ),
                    ),
                    const DelayedDisplay(
                        delay: Duration(milliseconds: 300),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                        )),
                    Positioned(
                      top: 200,
                      child: DelayedDisplay(
                        delay: Duration(milliseconds: 700),
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                            height: MediaQuery.of(context).size.height/1.45,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 55,left: 20,right: 51),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(food[0],style: TextStyle(
                                       fontSize: 16,fontWeight: FontWeight.w900
                                   ),),

                                  SizedBox(height: 30,),
                                   Text(text,
                                    style: TextStyle(fontSize: 15,color: Colors.grey),
                                  ),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 25),
                                    child: Divider(thickness: 1,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         const Text('Calories',style: TextStyle(
                                              fontSize: 13,color: Colors.grey
                                          ),),
                                          SizedBox(height: 6,),
                                            Text(cal
                                          ,style: TextStyle(
                                              fontSize: 17,color: Color(0xff1c7d4f),fontWeight: FontWeight.w900
                                          ),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('protien',style: TextStyle(
                                              fontSize: 13,color: Colors.grey
                                          ),),
                                          SizedBox(height: 6,),
                                          Text(pro,style: TextStyle(
                                              fontSize: 17,color: Color(0xff1c7d4f),fontWeight: FontWeight.w900
                                          ),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Calcium',style: TextStyle(
                                              fontSize: 13,color: Colors.grey
                                          ),),
                                          SizedBox(height: 6,),
                                           Text(cals,
                                            style: TextStyle(
                                              fontSize: 17,color: Color(0xff1c7d4f),fontWeight: FontWeight.w900
                                          ),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const[
                                          Text('CArbo',style: TextStyle(
                                              fontSize: 13,color: Colors.grey
                                          ),),
                                          SizedBox(height: 6,),
                                          Text('21 g',style: TextStyle(
                                              fontSize: 17,color: Color(0xff1c7d4f),fontWeight: FontWeight.w900
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 30),
                                    child: Divider(thickness: 1,),
                                  ),
                                  SizedBox(height: 15,),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: DelayedDisplay(
                        delay: Duration(milliseconds: 500),
                        child: Image.asset('${img}', height: 320,
                          width: 300,
                          fit: BoxFit.fitWidth,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
