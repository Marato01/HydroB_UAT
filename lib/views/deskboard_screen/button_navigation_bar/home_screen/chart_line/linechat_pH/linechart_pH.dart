import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
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
    // Initialize Hive box
    _box = await Hive.openBox<List<int>>('numberBox');

    // Load existing data from Hive
    List<int> storedNumbers = _box.get('numbers', defaultValue: [])!;

    // Convert stored numbers to chart data
    setState(() {
      _chartData = _convertToChartData(storedNumbers);
    });

    // Listen for Hive box changes
    _box.listenable().addListener(_updateChartFromHive);
  }

  List<_ChartData> _convertToChartData(List<int> numbers) {
    final now = DateTime.now();
    return numbers.asMap().entries.map((entry) {
      // Generate a DateTime for each entry, assuming 1-second intervals
      final timestamp = now.add(Duration(seconds: entry.key - numbers.length));
      return _ChartData(timestamp, entry.value.toDouble());
    }).toList();
  }

  void _updateChartFromHive() {
    List<int> storedNumbers = _box.get('numbers', defaultValue: [])!;
    setState(() {
      _chartData = _convertToChartData(storedNumbers);
    });
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    _box.listenable().removeListener(_updateChartFromHive);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
          margin: EdgeInsets.all(8),
          backgroundColor: Colors.grey[100],
          borderColor: Colors.grey.withOpacity(0.3),
          borderWidth: 1,
          title: ChartTitle(
            text: 'Live pH Data',
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          primaryXAxis: DateTimeAxis(
            axisLine: AxisLine(width: 1, color: Colors.grey),
            labelStyle: TextStyle(fontSize: 12, color: Colors.black),
            majorGridLines: MajorGridLines(width: 0),
            dateFormat: DateFormat('HH:mm'),
            rangePadding: ChartRangePadding.auto,
          ),
          primaryYAxis: NumericAxis(
            axisLine: AxisLine(width: 1, color: Colors.grey),
            labelStyle: TextStyle(fontSize: 12, color: Colors.black),
            majorGridLines: MajorGridLines(
              dashArray: [5, 5],
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          series: [
            SplineAreaSeries<_ChartData, DateTime>(
              dataSource: _chartData,
              xValueMapper: (_ChartData data, _) => data.time,
              yValueMapper: (_ChartData data, _) => data.value,
              gradient: LinearGradient(
                colors: [Colors.green.withOpacity(0.6), Colors.green.withOpacity(0.2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderColor: Colors.green,
              borderWidth: 2,
              markerSettings: MarkerSettings(
                isVisible: false,
                borderColor: Colors.green,
                borderWidth: 1,
                color: Colors.white,
              ),
              dataLabelSettings: DataLabelSettings(isVisible: false),
            ),
          ],
        )

      ),
    );
  }
}

class _ChartData {
  _ChartData(this.time, this.value);
  final DateTime time; // Use DateTime instead of int
  final double value;
}
