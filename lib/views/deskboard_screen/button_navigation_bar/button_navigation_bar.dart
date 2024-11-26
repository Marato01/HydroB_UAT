import 'dart:developer';
import 'package:HydroB_UAT/views/deskboard_screen/button_navigation_bar/setting/setting_screen.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';

class ButtonNavigationBar extends StatefulWidget {
  ButtonNavigationBar({super.key});

  @override
  State<ButtonNavigationBar> createState() => _ButtonNavigationBarState();
}

class _ButtonNavigationBarState extends State<ButtonNavigationBar> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 2;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      HomeScreen(
        controller: (_controller),
      ),
      const SettingScreen(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: const Color(0xFFFFFFFFFF),
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 20.0,
              notchColor: const Color(0xFFFF00712D),

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: true,
              durationInMilliSeconds: 300,

              itemLabelStyle: const TextStyle(fontSize: 10),

              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.pie_chart,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.pie_chart,
                    color: Colors.white,
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  itemLabel: 'Setting',
                ),
              ],
              onTap: (index) {
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
