import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'signIn/sign_in.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and Animation
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start the animation after the splash screen animation completes
    Future.delayed(const Duration(seconds: 3), () {
      _animationController.forward().then((_) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const SignIn(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/chiptree.png',
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.30),
                Lottie.asset(
                  'assets/lottie/Animation - 1723702783589.json', // Path to your Lottie animation file
                  width: MediaQuery.of(context).size.width * 0.13,
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Center(child: Text("UAT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),)
              ],
            )
        ),
      ),
    );
  }
}
