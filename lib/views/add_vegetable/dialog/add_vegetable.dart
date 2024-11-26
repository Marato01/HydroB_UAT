import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'option_add_vegetable/advance.dart';
import 'option_add_vegetable/basic.dart';

class AddNameVegetable extends StatefulWidget {
  @override
  State<AddNameVegetable> createState() => _AddNameVegetableState();
}

class _AddNameVegetableState extends State<AddNameVegetable> {
  //this variable use for check all form in app
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    final sizebox = SizedBox(height: MediaQuery.of(context).size.height * 0.05);

    return SingleChildScrollView(
      child: Container(
        // Container of Dailog show when call to use
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(
          children: [
            const Center(
              child: Text(
                'Add Vegetable',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Color(0xFFF00712D),
                    fontWeight: FontWeight.bold),
              ),
            ),
      
            sizebox,
      
            //handle button option Basic and Advance
            Center(
              child: AppinioAnimatedToggleTab(
                duration: const Duration(milliseconds: 150),
                offset: 0,
                callback: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                tabTexts: const [
                  'Basic',
                  'Advance',
                ],
                height: 20,
                width: 150,
                boxDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45.withOpacity(0.5),
                      spreadRadius: 0.50,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                animatedBoxDecoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFc3d2db).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  color: const Color(0xFFFF00712D),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                activeStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                inactiveStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
      
            sizebox,
      
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: const [
                  Basic(),
                  Advance(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
