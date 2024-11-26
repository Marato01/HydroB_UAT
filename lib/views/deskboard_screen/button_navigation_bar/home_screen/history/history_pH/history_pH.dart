import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../view_model/pH_data_provider.dart';

class HistoryPh extends StatefulWidget {
  const HistoryPh({super.key});

  @override
  State<HistoryPh> createState() => _HistoryPhState();
}

class _HistoryPhState extends State<HistoryPh> {
  @override
  Widget build(BuildContext context) {
    final pHDataProvider = Provider.of<PHDataProvider>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: pHDataProvider.chartData.length,
        itemBuilder: (context, index) {
          final data = pHDataProvider.chartData[index];
          final formattedTime = DateFormat('HH:mm:ss').format(data.time);
          return ListTile(
            title: Text('Time: $formattedTime'),
            subtitle: Text('pH: ${data.pH.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
