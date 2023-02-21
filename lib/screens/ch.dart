import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';



class Chart extends StatelessWidget{
  static const String id='Chart_screen';
  List<_exerciseData> data = [
    _exerciseData('one', 2.5),
    _exerciseData('two', 4),
    _exerciseData('three', 5),
    _exerciseData('four', 7),
    _exerciseData('five', 9)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Player History'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
            // Chart title
              title: ChartTitle(
                text: 'Player History',
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
              // Enable legend
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom
              ),
              palette: [
                Colors.orangeAccent
              ],
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_exerciseData, String>>[
                LineSeries<_exerciseData, String>(
                    dataSource: data,
                    xValueMapper: (_exerciseData data, _) => data.week,
                    yValueMapper: (_exerciseData data, _) => data.rate,
                    name: 'Performance',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),

        ]));
  }
}

class _exerciseData {
  _exerciseData(this.week, this.rate);

  final String week;
  final double rate;
}