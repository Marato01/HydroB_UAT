import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../add_vegetable/add_vegetable.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
            image: AssetImage('assets/images/pic_login.jpg'),
            fit: BoxFit.cover,
          ))),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.category,
                style: const TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: 'Lato', fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //handle HydroB container
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddVegetable()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/bgcatagory.jpg',
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.06,
                              left: MediaQuery.of(context).size.width * 0.05,
                              child: const Center(
                                child: Text(
                                  'Hydroponic',
                                  style: TextStyle(color: Colors.white, fontFamily: 'lato'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                    ),

                    //handle comingsoon1 container
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/bgcatagory.jpg',
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.40)),
                          ),
                          Center(
                            child: Text(
                              'Coming Soon',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.60)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //handle comingsoon2 container
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/bgcatagory.jpg',
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.40)),
                          ),
                          Center(
                            child: Text(
                              'Coming Soon',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.60)),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                    ),

                    //handle comingsoon3 container
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/bgcatagory.jpg',
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.40)),
                          ),
                          Center(
                            child: Text(
                              'Coming Soon',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.60)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
