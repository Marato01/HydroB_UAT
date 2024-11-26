import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../view_model/add_vegetable_provider.dart';
import '../../../../../view_model/set_value_ph_ec.dart';
import '../../../../../view_model/switch_provider_EC.dart';
import '../../../../../view_model/switch_provider_pH.dart';
import '../../../../add_vegetable/dialog/view.vegetable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseVegetableDialog extends StatefulWidget {
  const ChooseVegetableDialog({super.key});

  @override
  State<ChooseVegetableDialog> createState() => _ChooseVegetableDialogState();
}

class _ChooseVegetableDialogState extends State<ChooseVegetableDialog> {
  @override
  Widget build(BuildContext context) {
    final setValue = Provider.of<SetValueProvider>(context);
    final activatePH = Provider.of<SwitchProviderPH>(context);
    final activateEC = Provider.of<SwitchProviderEc>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.selectVegetable,
              style: const TextStyle(
                  fontFamily: 'lato',
                  color: Color(0xFFFF00712D),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Consumer<VetegetableProvider>(
              builder: (context, vegetableprovider, child) {
                return ListView.builder(
                  itemCount: vegetableprovider.item.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        if(activatePH.switchValue == false && activateEC.switchValue == false){

                          CherryToast.error(
                            toastDuration: const Duration(milliseconds: 1),
                            disableToastAnimation: true,
                            title: const Text(
                              'Bad request',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            action: const Text('At least have one activate'),
                            inheritThemeColors: true,
                            actionHandler: () {},
                            onToastClosed: () {},
                          ).show(context);

                        }else{
                          setValue.updateValues(
                              vegetableprovider.item[index].name,
                              vegetableprovider.item[index].minpH,
                              vegetableprovider.item[index].maxpH,
                              vegetableprovider.item[index].minEC,
                              vegetableprovider.item[index].maxEC);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        padding: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                              spreadRadius: 0.5, // How much the shadow spreads
                              blurRadius: 10,  // How blurry the shadow is
                              offset: const Offset(0, 2), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(vegetableprovider.item[index].name),
                            ),

                            //handle view value each vegetable
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      content: ViewVegetable(
                                        namevegetable: vegetableprovider.item[index].name,
                                        minph: vegetableprovider.item[index].minpH,
                                        maxph: vegetableprovider.item[index].maxpH,
                                        minEC: vegetableprovider.item[index].minEC,
                                        maxEC: vegetableprovider.item[index].maxEC,
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
