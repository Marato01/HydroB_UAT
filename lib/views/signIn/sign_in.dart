import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sign_in_option_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          //handle screen background
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pic_login.jpg'),
                    fit: BoxFit.cover)),
          ),

          Positioned(
            top: 0,
            child: Image.asset(
              'assets/icons/chiptree.png',
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.30,
            ),
          ),

          // handle button Sign In
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.10,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return SignInOptionScreen();
                    },

                    // handle animation when navigate to signInOptionScreen
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                  ),
                );
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0x0FFFFFBE6).withOpacity(0.5)),
                  child: Center(
                    child: Text(
                     AppLocalizations.of(context)!.signIn,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
