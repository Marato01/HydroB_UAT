import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../view_model/EC_data_provider.dart';

class HistoryEc extends StatefulWidget {
  const HistoryEc({super.key});

  @override
  State<HistoryEc> createState() => _HistoryEcState();
}

class _HistoryEcState extends State<HistoryEc> {
  @override
  Widget build(BuildContext context) {

    final EcDataProvider = Provider.of<ECDataProvider>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: EcDataProvider.chartData.length,
        itemBuilder: (context, index) {
          final data = EcDataProvider.chartData[index];
          final formattedTime = DateFormat('HH:mm:ss').format(data.time);
          return ListTile(
            title: Text('Time: $formattedTime'),
            subtitle: Text('EC: ${data.EC.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
