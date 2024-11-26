import 'package:flutter/material.dart';
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
                  'Chart Line',
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
                child: LinechartPH(),
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
