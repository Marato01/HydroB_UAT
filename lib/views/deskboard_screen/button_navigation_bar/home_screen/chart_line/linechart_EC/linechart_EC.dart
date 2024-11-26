import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinechartEc extends StatefulWidget {
  const LinechartEc({super.key});

  @override
  State<LinechartEc> createState() => _LinechartEcState();
}

class _LinechartEcState extends State<LinechartEc> {
  // final List<int> dataArray = [2, 5, 7, 9, 10, 4, 6, 5, 7, 6, 3, 4, 6, 7, 5];
  // final List<ChartData> chartData = [ChartData(DateTime.now(), 0)]; // Initial point
  // late Timer timer;
  // int index = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _startRealTimeUpdates();
  // }
  //
  // void _startRealTimeUpdates() {
  //   timer = Timer.periodic(const Duration(seconds: 2), (timer) {
  //     if (index < dataArray.length) {
  //       setState(() {
  //         chartData.add(
  //           ChartData(DateTime.now(), dataArray[index].toDouble()),
  //         );
  //         index++;
  //       });
  //     } else {
  //       timer.cancel();
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Maintenance'),
        // child: SfCartesianChart(
        //   primaryXAxis: DateTimeAxis(
        //     dateFormat: DateFormat('HH:mm:ss'),
        //     intervalType: DateTimeIntervalType.seconds,
        //     interval: 2,
        //   ),
        //   series: <CartesianSeries>[
        //     SplineSeries<ChartData, DateTime>(
        //       dataSource: chartData,
        //       xValueMapper: (ChartData data, _) => data.x,
        //       yValueMapper: (ChartData data, _) => data.y,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

// class ChartData {
//   ChartData(this.x, this.y);
//   final DateTime x;
//   final double y;
// }
