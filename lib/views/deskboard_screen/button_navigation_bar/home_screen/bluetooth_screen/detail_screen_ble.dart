import 'package:flutter/material.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

class DetailScreenBle extends StatelessWidget {
  final String deviceID;
  final int deviceRSSI;

  DetailScreenBle({super.key, required this.deviceID, required this.deviceRSSI});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: (){

      }),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Device Detail",
                style: TextStyle(
                    fontFamily: KhmerFonts.freehand,
                    package: 'khmer_fonts',
                    color: Color(0xFFF00712D),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text("ID: ${deviceID}"),
            Text("RSSI: ${deviceRSSI.toString()} dBm")
          ],
        ),
      ),
    );
  }
}
