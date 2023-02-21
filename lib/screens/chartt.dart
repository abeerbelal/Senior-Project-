import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<_exerciseData> exercises = [];

  Future<String> getJsonFromFirebase() async{
    String url = 'https://chart-data-binding-92bd0-default-rtdb.firebaseio.com/data.json';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future loadExerciseData() async{
    final String jsonString = await getJsonFromFirebase();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse){
      exercises.add(_exerciseData.fromJson(i));
    }
  }

  @override
  void initState(){
    loadExerciseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(future: getJsonFromFirebase(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  print("the array");
                  print(exercises);
                  return Column(
                    children: [
                      SfCartesianChart(
                        title: ChartTitle(
                          text: "Player Performance",
                          alignment: ChartAlignment.center ,
                        ),
                        primaryXAxis: CategoryAxis(
                            title: AxisTitle(
                                text: "Weeks"
                            )
                        ),
                        primaryYAxis: NumericAxis(
                            title: AxisTitle(
                                text: "Rate"
                            )
                        ),
                        legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom
                        ),
                        palette: [
                          Colors.orangeAccent
                        ],
                        tooltipBehavior: TooltipBehavior(enable: true),

                        series: <ChartSeries<_exerciseData, String>>[
                          LineSeries<_exerciseData, String>(
                              name: "performance",
                              width: .09,
                              dataSource: exercises,
                              xValueMapper: (_exerciseData detailes, _) => detailes.week,
                              yValueMapper: (_exerciseData detailes, _) => detailes.rate,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                              )
                          ),
                        ],
                      ),
                    ],
                  );
                }else{
                  return Center(child: CircularProgressIndicator());
                }
              } ,)
        ));
  }

}
class _exerciseData{
  _exerciseData(this.week,this.rate);

  final String week;
  final double rate;

  factory _exerciseData.fromJson(Map<String, dynamic> parsedJson){
    return _exerciseData(parsedJson['week'].toString(), parsedJson['rate']);
  }
}
