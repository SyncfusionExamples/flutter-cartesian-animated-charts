import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  late List<_SalesData> data;
  int count = 11;
  @override
  void initState() {
    data = [
      _SalesData(1, 35),
      _SalesData(2, 28),
      _SalesData(3, 34),
      _SalesData(4, 26),
      _SalesData(5, 35),
      _SalesData(6, 28),
      _SalesData(7, 32),
      _SalesData(8, 28),
      _SalesData(9, 32),
      _SalesData(10, 35),
    ];
    super.initState();
  }

  // Initialized a global variable for ChartSeriesController class
  ChartSeriesController? _chartSeriesController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SizedBox(
            height: 50,
          ),
          Container(
              height: 550,
              child: SfCartesianChart(
                  backgroundColor: Colors.white,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: NumericAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift),
                  primaryYAxis: NumericAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      minimum: 20,
                      maximum: 50,
                      interval: 5),
                  series: <ChartSeries<_SalesData, num>>[
                    LineSeries<_SalesData, num>(
                      // Animation duration for this line series set to 2000
                      animationDuration: 2000,
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                    )
                  ])),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  child: ButtonTheme(
                      minWidth: 40.0,
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: () {
                          _chartSeriesController?.animate();
                        },
                        child: Text('Animate line series',
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.white)),
                      ))),
              Container(
                  child: ButtonTheme(
                      minWidth: 40.0,
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: () {
                          addChartData();
                        },
                        child: Text('Add data point',
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.white)),
                      ))),
            ],
          )
        ]));
  }

  addChartData() {
    setState(() {
      data = getChartData();
    });
  }

  double getRandomInt(double min, double max) {
    final Random random = Random();
    return min + random.nextInt((max - min).toInt());
  }

  List<_SalesData> getChartData() {
    data.add(_SalesData(count.floor(), getRandomInt(20, 50)));
    count = count + 1;
    return data;
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final int year;
  final double sales;
}
