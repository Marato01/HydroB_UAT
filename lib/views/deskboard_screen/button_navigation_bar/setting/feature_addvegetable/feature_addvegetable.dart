import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../view_model/add_vegetable_provider.dart';
import '../../../../add_vegetable/dialog/add_vegetable.dart';
import '../../../../add_vegetable/dialog/delete_vegetable_list.dart';
import '../../../../add_vegetable/dialog/edit_vegetable.dart';
import '../../../../add_vegetable/dialog/view.vegetable.dart';
import '../../button_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FeatureAddvegetable extends StatefulWidget {
  const FeatureAddvegetable({super.key});

  @override
  State<FeatureAddvegetable> createState() => _FeatureAddvegetableState();
}

class _FeatureAddvegetableState extends State<FeatureAddvegetable> {

  final sizebox = const SizedBox(width: 10);

  @override
  Widget build(BuildContext context) {

    void showAddVegetableDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: AddNameVegetable(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ButtonNavigationBar()));
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF5F5F7),
        title: Text(
          AppLocalizations.of(context)!.addVegetable,
          style: const TextStyle(
              fontFamily: 'Lato',
              color: Color(0xFFF00712D),
              fontWeight: FontWeight.bold),
        ),
      ),

      // Handle listing when data is present
      body: Consumer<VetegetableProvider>(
        builder: (context, vegetableProvider, child) {
          if (vegetableProvider.item.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vegetableProvider.item.length + 1,
                    // +1 for the Icon/Container at the end
                    itemBuilder: (ctx, index) {
                      if (index == vegetableProvider.item.length) {
                        return GestureDetector(
                          onTap: (){
                            showAddVegetableDialog();
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
                            child: const Center(child: Icon(Icons.add)),
                          ),
                        );
                      }

                      return Container(
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
                            Text(vegetableProvider.item[index].name, style: const TextStyle(fontFamily: 'lato', fontWeight: FontWeight.bold, color: Colors.black),),
                            Row(
                              children: [
                                // Button to show dialog for editing vegetable
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: EditVegetable(index: index),
                                        );
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/icons/write.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                sizebox,
                                // Button to view vegetable details
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: ViewVegetable(
                                            namevegetable: vegetableProvider
                                                .item[index].name,
                                            minph: vegetableProvider
                                                .item[index].minpH,
                                            maxph: vegetableProvider
                                                .item[index].maxpH,
                                            minEC: vegetableProvider
                                                .item[index].minEC,
                                            maxEC: vegetableProvider
                                                .item[index].maxEC,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/icons/detail.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                sizebox,
                                // Button to delete vegetable
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content:
                                          DeleteVegetableList(index: index),
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
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: (){
                showAddVegetableDialog();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFF3C3D37).withOpacity(0.10),
                ),
                child: const Center(child: Icon(Icons.add)),
              ),
            );
          }
        },
      ),
    );
  }
}
