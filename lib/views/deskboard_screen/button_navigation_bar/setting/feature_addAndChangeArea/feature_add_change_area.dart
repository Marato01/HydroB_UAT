import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../view_model/add_area_provider.dart';
import '../../../../add_area/dialog/delete_area_dialog.dart';
import '../../../../add_area/dialog/name_area_dialog.dart';
import '../../../../add_area/dialog/rename_dialog.dart';
import '../../button_navigation_bar.dart';

class FeatureAddChangeArea extends StatefulWidget {
  const FeatureAddChangeArea({super.key});

  @override
  State<FeatureAddChangeArea> createState() => _FeatureAddChangeAreaState();
}

class _FeatureAddChangeAreaState extends State<FeatureAddChangeArea> {
  @override
  Widget build(BuildContext context) {

    void showAddAreaDailog() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: NameAreaDialog(),
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
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF5F5F7),
        title: Text(
          AppLocalizations.of(context)!.selectArea,
          style: const TextStyle(
              fontFamily: 'Lato',
              color: Color(0xFFF00712D),
              fontWeight: FontWeight.bold),
        ),
      ),

      //handle list
      body: Consumer<AddAreaProvider>(
        builder: (context, addAreaProvider, child) {
          if (addAreaProvider.area.isNotEmpty){
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: addAreaProvider.area.length + 1,
                    itemBuilder: (ctx, index) {
                      if(index == addAreaProvider.area.length){
                        return GestureDetector(
                          onTap: (){
                            showAddAreaDailog();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green.withOpacity(0.20),
                            ),
                            child: Center(child: Text(AppLocalizations.of(context)!.addArea, style: const TextStyle(fontFamily: 'lato'),),
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Provider.of<AddAreaProvider>(context,listen: false).updateData(addAreaProvider.area[index].names);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ButtonNavigationBar()));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                                spreadRadius: 1, // How much the shadow spreads
                                blurRadius: 10,  // How blurry the shadow is
                                offset: const Offset(0, 2), // Offset in the x and y direction
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(addAreaProvider.area[index].names, style: const TextStyle(fontFamily: 'lato', fontWeight: FontWeight.bold, color: Colors.black),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              content: RenameDialog(index: index),
                                            );
                                          });
                                    },
                                    child: Image.asset(
                                      'assets/icons/write.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            content: DeleteAreaDialog(index: index),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/icons/minus-button.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: (){
                showAddAreaDailog();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFF3C3D37).withOpacity(0.10),
                ),
                child: const Center(child: Text('Add Area', style: TextStyle(fontFamily: 'lato'),)),
              ),
            );
          }
        },
      ),
    );
  }
}
