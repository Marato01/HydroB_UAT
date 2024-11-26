import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../../view_model/add_area_provider.dart';
import '../../../../../view_model/add_vegetable_provider.dart';
import '../../../../../view_model/profile_picker_provider.dart';
import '../../button_navigation_bar.dart';
import 'dialog_logOut/logOut_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final countvegetable = Provider.of<VetegetableProvider>(context);
    final countarea = Provider.of<AddAreaProvider>(context);
    final sizebox = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );

    //function call display dialog
    void showAddAreaDailog() {
      showDialog(
        context: context,
        builder: (_) {
          return const AlertDialog(
            content: LogoutDialog(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ButtonNavigationBar()));
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Color(0xFFFF00712D),
              fontWeight: FontWeight.bold,
              fontFamily: 'lato'),
        ),
        backgroundColor: const Color(0xFFFFF5F5F7),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/bgcatagory.jpg',
                              fit: BoxFit.cover,
                            )),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.09,
                  left: MediaQuery.of(context).size.width * 0.34,
                  child: Consumer<ProfileImageProvider>(
                    builder: (context, profileImageProvider, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          profileImageProvider.imagePath != null
                              ? GestureDetector(
                                  onTap: () async {
                                    showBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,
                                          width: MediaQuery.of(context).size.width * 0.90,
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.camera_alt_outlined),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String? imagePath = await pickImage();
                                                      if (imagePath != null) {
                                                        profileImageProvider.setImage(imagePath);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text(
                                                        'Change Profile'),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: FileImage(
                                        File(profileImageProvider.imagePath!)),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    String? imagePath = await pickImage();
                                    if (imagePath != null) {
                                      profileImageProvider.setImage(imagePath);
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 40,
                                    child: Icon(Icons.person),
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Center(
              child: Text(
                'Sam sothavy',
                style: TextStyle(
                    fontFamily: 'lato',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            sizebox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '${countvegetable.item.length}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'lato'),
                    ),
                    Text(
                      AppLocalizations.of(context)!.vegetable,
                      style: const TextStyle(fontFamily: 'lato'),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Column(
                  children: [
                    Text(
                      '${countarea.area.length}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'lato'),
                    ),
                    Text(
                      AppLocalizations.of(context)!.area,
                      style: const TextStyle(fontFamily: 'lato'),
                    ),
                  ],
                )
              ],
            ),
            sizebox,
            Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black54,
                ),
                child: const Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        'samsothavy@gmail.com',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'lato'),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.phone_android_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        '095 240 836',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'lato'),
                      ),
                    ),
                  ],
                )),
            sizebox,
            GestureDetector(
              onTap: () {
                showAddAreaDailog();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFFC80036),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.logout,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'lato'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Function for pick image from our gallery
  Future<String?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }
}
