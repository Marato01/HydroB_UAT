import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/add_vegetable_provider.dart';

class DeleteVegetableList extends StatefulWidget {

  final int index;

  DeleteVegetableList({required this.index});

  @override
  State<DeleteVegetableList> createState() => _DeleteVegetableListState();
}

class _DeleteVegetableListState extends State<DeleteVegetableList> {


  @override
  Widget build(BuildContext context) {
    final sizebox = SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Center(
        child: Column(
          children: [
            const Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            sizebox,
            const Text(
              'Are you sure you want to delete this item?',
              style: TextStyle(fontSize: 10),
            ),
            sizebox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text('Cancel'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Provider.of<VetegetableProvider>(context, listen: false)
                        .removeVegetable(widget.index);
                    Navigator.pop(context);
                    CherryToast.success(
                      toastDuration: const Duration(milliseconds: 1),
                      disableToastAnimation: true,
                      title: const Text(
                        'Delete succesful',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      inheritThemeColors: true,
                      actionHandler: () {},
                      onToastClosed: () {},
                    ).show(context);

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text('Delete'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
