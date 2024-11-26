import 'package:HydroB_UAT/views/deskboard_screen/button_navigation_bar/home_screen/profile/profile_screen.dart';
import 'package:HydroB_UAT/views/deskboard_screen/button_navigation_bar/home_screen/scanQR/scanQR.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/profile_picker_provider.dart';
import 'bluetooth_screen/bluetooth-screen.dart';
import 'notification/notification.dart';


class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {

    final profileImageProvider = Provider.of<ProfileImageProvider>(context);

    //handle spcaing between icon and text bluetooth
    final sizebox = SizedBox(
      width: MediaQuery.of(context).size.width * 0.05,
    );

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // this container handle Image Profile
          GestureDetector(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileScreen()));

            },
            child: CircleAvatar(
              radius: 25,
              backgroundImage: profileImageProvider.loadImage(), // Load image from provider
              child: profileImageProvider.imagePath == null
                  ? const Icon(Icons.person) // Show icon if no image
                  : null,
            ),
          ),

          //this container handle screen of icon alert and connection
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Notificationn()));
                  },
                  child: Image.asset(
                    'assets/icons/notification.png',
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),

                // handle button connection
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFFFFBE6),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'Select Option',
                                    style: TextStyle(
                                        color: Color(0xFFFF00712D),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'lato',
                                        fontSize: 20),
                                  ),
                                ),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.05),

                                GestureDetector(
                                  onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) =>BLEScanner()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.60,
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFFF76BB91)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icons/find-my-gadget-app.png',
                                            height: MediaQuery.of(context).size.height * 0.10,
                                            width: MediaQuery.of(context).size.width * 0.10,
                                          ),
                                        ),
                                        sizebox,
                                        const Text('Bluetooth'),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.03),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQR()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.60,
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFFF76BB91)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icons/scan.png',
                                            height: MediaQuery.of(context).size.height * 0.10,
                                            width: MediaQuery.of(context).size.width * 0.10,
                                          ),
                                        ),
                                        sizebox,
                                        const Text('Scan QR'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    'assets/icons/link.png',
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
