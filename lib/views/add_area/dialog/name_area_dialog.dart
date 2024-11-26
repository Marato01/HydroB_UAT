import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/add_area_provider.dart';

class NameAreaDialog extends StatefulWidget {
  @override
  State<NameAreaDialog> createState() => _NameAreaDialogState();
}

class _NameAreaDialogState extends State<NameAreaDialog> {
  var globlekey = GlobalKey<FormState>();
  var nameareaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizebox = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Column(
        children: [
          const Center(
            child: Text(
              'Add Area',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                  color: Color(0xFFF00712D),
                  fontWeight: FontWeight.bold),
            ),
          ),
          sizebox,
          Form(
            key: globlekey,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.withOpacity(0.50),
              ),
              child: TextFormField(
                validator: (area) {
                  if (!validateEmpty(area.toString()))
                    return null;
                  else
                    return 'name must be not empty';
                },
                onFieldSubmitted: (_) {
                  if (globlekey.currentState!.validate()) {
                    globlekey.currentState!.save();
                  }
                },
                controller: nameareaController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
              ),
            ),
          ),
          sizebox,
          GestureDetector(
            onTap: () {
              if (globlekey.currentState!.validate()) {
                globlekey.currentState!.save();
                Provider.of<AddAreaProvider>(context, listen: false)
                    .addArea(nameareaController.text);
                Navigator.of(context).pop();
                CherryToast.success(
                  toastDuration: const Duration(milliseconds: 1),
                  disableToastAnimation: true,
                  title: const Text(
                    'Add Successful',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  inheritThemeColors: true,
                  actionHandler: () {},
                  onToastClosed: () {},
                ).show(context);
              } else {
                CherryToast.error(
                  toastDuration: const Duration(milliseconds: 1),
                  disableToastAnimation: true,
                  title: const Text(
                    'Invalid Input',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  action: const Text('Name must not empty'),
                  inheritThemeColors: true,
                  actionHandler: () {},
                  onToastClosed: () {},
                ).show(context);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.green),
              child: const Center(
                child: Text('Add', style: TextStyle(fontFamily: 'lato'),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateEmpty(String value) => value.isEmpty ? true : false;
}
