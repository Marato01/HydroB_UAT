import 'dart:async';
import 'package:flutter/material.dart';

class PHDataProvider with ChangeNotifier {
  List<ChartData> _chartData = [];
  late DateTime _startTime;

  List<ChartData> get chartData => _chartData;

  PHDataProvider() {
    _startTime = DateTime.now();
    _updateData();
    Timer.periodic(const Duration(seconds: 1), _updateData);
  }

  void _updateData([Timer? timer]) {
    final currentTime = DateTime.now();
    final pH = 7 + 0.01 * (currentTime.second % 100); // Simulated pH value
    _chartData.add(ChartData(currentTime, pH));
    notifyListeners();
  }
}

class ChartData {
  ChartData(this.time, this.pH);
  final DateTime time;
  final double pH;
}
