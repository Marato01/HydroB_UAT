import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/add_area_provider.dart';


class RenameDialog extends StatefulWidget {

 final int index;

  const RenameDialog({super.key, required this.index});

  @override
  State<RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {

  var globlekey = GlobalKey<FormState>();

  final TextEditingController _nameareaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // You can set initial values for the text fields using the provider
    final addAreaProvider = Provider.of<AddAreaProvider>(context, listen: false);
    final nameArea = addAreaProvider.getArea(widget.index);
    _nameareaController.text = nameArea.names;

  }

  @override
  Widget build(BuildContext context) {
    final sizebox = SizedBox(height: MediaQuery.of(context).size.height * 0.03,);
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Column(
        children: [
          const Center(
            child: Text(
              'Rename Area',
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
                controller: _nameareaController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          sizebox,

          //save back
          GestureDetector(
            onTap: (){

              if (_nameareaController.text.isNotEmpty) {
                Provider.of<AddAreaProvider>(context, listen: false)
                    .updateArea(widget.index, _nameareaController.text,);
                Navigator.of(context).pop(); // Close the dialog
                CherryToast.success(
                  toastDuration: const Duration(milliseconds: 1),
                  disableToastAnimation: true,
                  title: const Text(
                    'Rename succesful',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  inheritThemeColors: true,
                  actionHandler: () {},
                  onToastClosed: () {},
                ).show(context);
              }else{
                CherryToast.error(
                  toastDuration: const Duration(milliseconds: 1),
                  disableToastAnimation: true,
                  title: const Text(
                    'Invalid Input',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  action: const Text('Rename must not empty'),
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
                child: Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateEmpty(String value) => value.isEmpty ? true : false;
}
