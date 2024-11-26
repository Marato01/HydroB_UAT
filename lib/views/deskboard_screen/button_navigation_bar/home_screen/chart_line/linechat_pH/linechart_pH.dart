import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinechartPH extends StatefulWidget {
  const LinechartPH({super.key});

  @override
  State<LinechartPH> createState() => _LinechartPHState();
}

class _LinechartPHState extends State<LinechartPH> {

  List<_ChartData> _chartData = [];
  late Box<List<int>> _box;
  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    // Open the Hive box
    _box = await Hive.openBox<List<int>>('numberBox');

    // Load existing data from Hive
    List<int> storedNumbers = _box.get('numbers', defaultValue: [])!;

    // Convert stored numbers to chart data
    setState(() {
      _chartData = storedNumbers.asMap().entries.map((entry) {
        return _ChartData(entry.key, entry.value.toDouble());
      }).toList();
    });

    // Listen for Hive box changes
    _box.listenable().addListener(_updateChartFromHive);
  }

  void _updateChartFromHive() {
    List<int> storedNumbers = _box.get('numbers', defaultValue: [])!;

    setState(() {
      _chartData = storedNumbers.asMap().entries.map((entry) {
        return _ChartData(entry.key, entry.value.toDouble());
      }).toList();
    });
  }

  // @override
  // void dispose() {
  //   // Remove the listener when the widget is disposed
  //   _box.listenable().removeListener(_updateChartFromHive);
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SfCartesianChart(
            primaryXAxis: NumericAxis(
              title: AxisTitle(text: 'Time'),
              isVisible: true, // Make X-axis visible
            ),
            primaryYAxis: NumericAxis(
              // title: AxisTitle(text: 'Value'),
              isVisible: true, // Make Y-axis visible
            ),
            series:[
              SplineAreaSeries<_ChartData, int>(
                dataSource: _chartData,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                color: Colors.green.withOpacity(0.3),
                borderColor: Colors.green,
                borderWidth: 2,
                // Optional: Add data labels
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.auto,
                ),
              ),
            ],
          )
      ),
    );
  }
}
class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final double y;
}

