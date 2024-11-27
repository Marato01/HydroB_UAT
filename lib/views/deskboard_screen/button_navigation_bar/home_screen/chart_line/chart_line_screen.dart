import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../view_model/Bluetooth_provider/BLEProvider.dart';
import '../../button_navigation_bar.dart';
import '../history/history_screen.dart';
import 'linechart_EC/linechart_EC.dart';
import 'linechat_pH/linechart_pH.dart';

class ChartLineScreen extends StatefulWidget {
  const ChartLineScreen({super.key});

  @override
  State<ChartLineScreen> createState() => _ChartLineScreenState();
}

class _ChartLineScreenState extends State<ChartLineScreen> {

  String dropdownValue = 'one';

  @override
  Widget build(BuildContext context) {
    final heightsize = SizedBox(height: MediaQuery.of(context).size.height * 0.05);

    return Scaffold(
        // body: Center(child: Text('Maintenance'),),
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/pic_login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            children: [
              Center(
                child: Text(
                  '',
                  style: TextStyle(
                      color: Color(0xFFFF00712D),
                      fontSize: 25,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ButtonNavigationBar()));
                    },
                    child: Image.asset(
                      'assets/icons/deskboard.png',
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryScreen()));
                    },
                    child: Image.asset(
                      'assets/icons/history.png',
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                ],
              ),
              heightsize,
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      // Shadow color with opacity
                      spreadRadius: 4,
                      // How far the shadow spreads
                      blurRadius: 7,
                      // How soft the shadow is
                      offset: Offset(0, 3), // The position of the shadow (x, y)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                       DropdownButton<String>(
                         value: dropdownValue,
                         icon: const Icon(Icons.arrow_drop_down),
                         style: const TextStyle(color: Colors.black),
                         underline: Container(
                           height: 1,
                           color: Colors.black26,
                         ),
                         onChanged: (String? newValue){
                           setState(() {
                             dropdownValue = newValue!;

                             if (dropdownValue == 'one') {
                               print("now");
                             } else if (dropdownValue == 'two') {
                               print("3h");
                             } else if (dropdownValue == 'three'){
                               print("1d");
                             }
                           });
                         },

                         items: const[
                           DropdownMenuItem<String>(
                             value: 'one',
                               child: Text('now')),

                           DropdownMenuItem<String>(
                               value: 'two',
                               child: Text('3h')),

                           DropdownMenuItem<String>(
                               value: 'three',
                               child: Text('1d')),
                         ],
                       ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text('pH', style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Consumer<BLEProvider>(
                              builder: (context, bleProvider, child) {
                                final number = bleProvider.latestNumber;
                                if (number != null) {
                                  if (number < 7) {
                                    return Text(
                                      "${number.toString()} ACID",
                                      style: TextStyle(color: Colors.red),
                                    );
                                  } else if (number > 7) {
                                    return Text(
                                      "${number.toString()} ALKALINE",
                                      style: TextStyle(color: Colors.deepPurpleAccent),
                                    );
                                  } else if (number == 7) {
                                    return Text(
                                      "${number.toString()} NEUTRAL",
                                      style: TextStyle(color: Colors.green),
                                    );
                                  }
                                }
                                return Text(
                                  "Turn on bluetooth",
                                  style: TextStyle(color: Colors.grey, fontSize: 10),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),

                    Expanded(child: LinechartPH()),
                  ],
                )
              ),
              heightsize,
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      // Shadow color with opacity
                      spreadRadius: 4,
                      // How far the shadow spreads
                      blurRadius: 7,
                      // How soft the shadow is
                      offset: Offset(0, 3), // The position of the shadow (x, y)
                    ),
                  ],
                ),
                child: LinechartEc(),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
