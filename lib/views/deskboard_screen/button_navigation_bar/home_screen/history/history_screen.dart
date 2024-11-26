import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:flutter/material.dart';
import '../../button_navigation_bar.dart';
import '../chart_line/chart_line_screen.dart';
import 'history_EC/history_EC.dart';
import 'history_pH/history_pH.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Maintenance'),),
    //     body: Stack(
    //   children: [
    //
    //     Container(
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage('assets/images/pic_login.jpg'),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //
    //
    //     Padding(
    //       padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
    //       child: Column(
    //         children: [
    //           Center(
    //             child: Text(
    //               'History',
    //               style: TextStyle(
    //                   color: Color(0xFFFF00712D),
    //                   fontSize: 25,
    //                   fontFamily: 'Lato',
    //                   fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Row(
    //             children: [
    //               GestureDetector(
    //                 onTap: () {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => ButtonNavigationBar()));
    //                 },
    //                 child: Image.asset(
    //                   'assets/icons/deskboard.png',
    //                   height: MediaQuery.of(context).size.height * 0.06,
    //                   width: MediaQuery.of(context).size.width * 0.06,
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: MediaQuery.of(context).size.width * 0.05,
    //               ),
    //               GestureDetector(
    //                 onTap: () {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => ChartLineScreen()));
    //                 },
    //                 child: Image.asset(
    //                   'assets/icons/chart.png',
    //                   height: MediaQuery.of(context).size.height * 0.06,
    //                   width: MediaQuery.of(context).size.width * 0.06,
    //                 ),
    //               )
    //             ],
    //           ),
    //
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.05,
    //           ),
    //
    //           //handle switch button pH and EC
    //           Center(
    //             child: AppinioAnimatedToggleTab(
    //               duration: const Duration(milliseconds: 150),
    //               offset: 0,
    //               callback: (int index) {
    //                 setState(() {
    //                   currentIndex = index;
    //                 });
    //               },
    //               tabTexts: const [
    //                 'pH',
    //                 'EC',
    //               ],
    //               height: 30,
    //               width: 200,
    //               boxDecoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(20),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black45.withOpacity(0.5),
    //                     spreadRadius: 0.50,
    //                     blurRadius: 4,
    //                     offset: Offset(2, 2),
    //                   ),
    //                 ],
    //               ),
    //               animatedBoxDecoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: const Color(0xFFc3d2db).withOpacity(0.1),
    //                     spreadRadius: 1,
    //                     blurRadius: 5,
    //                     offset: const Offset(2, 2),
    //                   ),
    //                 ],
    //                 color: Color(0xFFFF00712D),
    //                 borderRadius: const BorderRadius.all(
    //                   Radius.circular(20),
    //                 ),
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1,
    //                 ),
    //               ),
    //               activeStyle: const TextStyle(
    //                 fontSize: 16,
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //               inactiveStyle: const TextStyle(
    //                 fontSize: 16,
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             ),
    //           ),
    //
    //           const SizedBox(
    //             height: 70,
    //           ),
    //
    //           ClipRRect(
    //             borderRadius: BorderRadius.circular(20),
    //             child: Container(
    //               height: MediaQuery.of(context).size.height * 0.50,
    //               decoration: BoxDecoration(
    //                 color: Colors.blue,
    //                 borderRadius: BorderRadius.circular(20),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(0.2),
    //                     // Shadow color with transparency
    //                     spreadRadius: 5,
    //                     // How much the shadow will spread
    //                     blurRadius: 10,
    //                     // The blur effect of the shadow
    //                     offset: Offset(0, 3), // The position of the shadow (x, y)
    //                   ),
    //                 ],
    //               ),
    //               child: IndexedStack(
    //                 index: currentIndex,
    //                 children: [
    //                   HistoryPh(),
    //                   HistoryEc(),
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     )
    //   ],
    // )
         );
  }
}
