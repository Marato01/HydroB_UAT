import 'package:flutter/material.dart';
import 'package:khmer_fonts/khmer_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:riff_switch/riff_switch.dart';
import '../../../../../view_model/Bluetooth_provider/BLEProvider.dart';
import '../../../../../view_model/Bluetooth_provider/Switch_provider.dart';
import '../../button_navigation_bar.dart';
import 'detail_screen_ble.dart';

class BLEScanner extends StatefulWidget {
  BLEScanner({super.key});
  @override
  State<BLEScanner> createState() => _BLEScannerState();
}

class _BLEScannerState extends State<BLEScanner> {

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothSwitchProvider = Provider.of<BluetoothSwitchProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
        child: Consumer<BLEProvider>(
          builder: (context, bleProvider, child) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ButtonNavigationBar(),
                          ),
                        );
                      },
                      child: const Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    const Text(
                      "Bluetooth",
                      style: TextStyle(
                        fontFamily: KhmerFonts.freehand,
                        package: 'khmer_fonts',
                        color: const Color(0xFFF00712D),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RiffSwitch(
                      activeColor: const Color(0xFFFF00712D),
                      value: bluetoothSwitchProvider.blueSwitch,
                      onChanged: (value) {
                        bluetoothSwitchProvider.setBlueSwitch(value);
                        if (value) {
                          bleProvider.startScan(context);
                        } else {
                          bleProvider.stopScan();
                          bleProvider.disconnect();
                        }
                      },
                      type: RiffSwitchType.cupertino,
                    ),
                  ],
                ),
                if (bleProvider.isScanning)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Lottie.asset(
                      'assets/lottie/Animation - 1729670874357.json',
                      height: MediaQuery.of(context).size.height * 0.09,
                      repeat: true,
                      reverse: false,
                      animate: true,
                    ),
                  ),

                if(bluetoothSwitchProvider.blueSwitch)
                Expanded(
                  child: ListView.builder(
                    itemCount: bleProvider.devices.length,
                    itemBuilder: (context, index) {
                      final device = bleProvider.devices[index];
                      final isSelected = device.id == bleProvider.selectedDevice?.id;
                      return GestureDetector(
                        onTap: () {
                          bleProvider.connectToDevice(device).catchError((error) {
                            _showErrorDialog('Connection Error', error.toString());
                          });
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(isSelected
                                      ? Icons.bluetooth_connected
                                      : Icons.bluetooth),
                                  Text(
                                    device.name.isNotEmpty
                                        ? device.name
                                        : 'Unknown Device',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreenBle(
                                        deviceID: device.id,
                                        deviceRSSI: device.rssi,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.navigate_next),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),


                if (bleProvider.isConnected) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                print('write data');
                                bleProvider.writeCharacteristic("1")
                                .catchError(
                                      (error) {
                                    _showErrorDialog('Write Error', error.toString());
                                  },
                                );
                              },
                              icon: const Icon(Icons.upload),
                              label: const Text('Write'),
                            ),
                            ElevatedButton.icon(
                              onPressed: bleProvider.disconnect,
                              icon: const Icon(Icons.bluetooth_disabled),
                              label: const Text('Dis'),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          color: Colors.amber,
                          child: Center(
                            child: Consumer<BLEProvider>(
                              builder: (context, bleProvider, child) {
                                final number = bleProvider.latestNumber;
                                return Text(
                                  number != null ? number.toString() : 'No data received',
                                  style: TextStyle(fontSize: 24),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
