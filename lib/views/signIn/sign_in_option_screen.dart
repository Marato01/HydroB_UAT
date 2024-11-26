import 'package:flutter/material.dart';
import '../add_vegetable/add_vegetable.dart';

class SignInOptionScreen extends StatefulWidget {
   SignInOptionScreen({super.key});

  @override
  State<SignInOptionScreen> createState() => _SignInOptionScreenState();
}

class _SignInOptionScreenState extends State<SignInOptionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          //handle background image
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
            image: AssetImage('assets/images/signIn.jpg'),
            fit: BoxFit.cover,
          ))),

          //handle Text "Sign In"
          const Text('Sign In',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00712D),
                  fontSize: 25,
                  fontFamily: 'Lato')),
          //hand option Google and Apple
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // handle Google button
                GestureDetector(
                  onTap: () {
                   print('google sing in');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          // Shadow color with opacity
                          spreadRadius: 2,
                          // The extent of the shadow
                          blurRadius: 7,
                          // The blur effect
                          offset: const Offset(0,
                              3), // Offset of the shadow (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/google.png',
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.10,
                      ),
                    ),
                  ),
                ),

                //handle space between Google and apple
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.10,
                ),

                // handle apple button
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddVegetable()));
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          // Shadow color with opacity
                          spreadRadius: 2,
                          // The extent of the shadow
                          blurRadius: 7,
                          // The blur effect
                          offset: const Offset(0,
                              3), // Offset of the shadow (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/apple.png',
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.10,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
