import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/add_vegetable_provider.dart';

class EditVegetable extends StatefulWidget {

  final int index;

  const EditVegetable({super.key, required this.index});

  @override
  State<EditVegetable> createState() => _EditVegetableState();
}

class _EditVegetableState extends State<EditVegetable> {


  var globlekey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _minphController = TextEditingController();
  final TextEditingController _maxphController = TextEditingController();
  final TextEditingController _minECController = TextEditingController();
  final TextEditingController _maxECController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // You can set initial values for the text fields using the provider
    final vegetableProvider = Provider.of<VetegetableProvider>(context, listen: false);
    final vegetable = vegetableProvider.getVegetable(widget.index);
    _nameController.text = vegetable.name;
    _minphController.text = vegetable.minpH.toString();
    _maxphController.text = vegetable.maxpH.toString();
    _minECController.text = vegetable.minEC.toString();
    _maxECController.text = vegetable.maxEC.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _minphController.dispose();
    _maxphController.dispose();
    _minECController.dispose();
    _maxECController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      // Container of Dailog show when call to use
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.height * 0.30,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text('Modify Vegetable' , style: TextStyle(fontSize: 20, fontFamily: 'Lato',color: Color(0xFFF00712D), fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Form(
              key: globlekey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Center(child: Text('Vegetable',style: TextStyle(fontSize: 13,color: Color(0xFFF00712D))))),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green.withOpacity(0.50),
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            validator: (name) {
                              if (!validateEmpty(name.toString()))
                                return null;
                              else
                                return 'name must be not empty';
                            },
                            onFieldSubmitted: (_) {
                              if (globlekey.currentState!.validate()) {
                                globlekey.currentState!.save();
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none),),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Center(
                              child: Text('Min pH',style: TextStyle(fontSize: 13,color: Color(0xFFF00712D))),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width * 0.50,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.withOpacity(0.50),
                              ),
                              child: TextFormField(
                                controller: _minphController,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(fontSize: 10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Expanded(
                        child: Column(
                          children: [
                            const Center(
                              child: Text('Max pH',style: TextStyle(fontSize: 13,color: Color(0xFFF00712D))),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width * 0.50,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.withOpacity(0.50),
                              ),
                              child: TextFormField(
                                controller: _maxphController,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(fontSize: 10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Center(
                              child: Text('Min EC',style: TextStyle(fontSize: 13,color: Color(0xFFF00712D))),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width * 0.50,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.withOpacity(0.50),
                              ),
                              child: TextFormField(
                                controller: _minECController,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(fontSize: 10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),
                                  suffixText: 'mS/m',
                                  suffixStyle: const TextStyle(fontSize: 10),
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Expanded(
                        child: Column(
                          children: [
                            const Center(
                              child: Text('Max EC' ,style: TextStyle(fontSize: 13,color: Color(0xFFF00712D))),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width * 0.50,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.withOpacity(0.50),
                              ),
                              child: TextFormField(
                                controller: _maxECController,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(fontSize: 10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),
                                  suffixText: 'mS/m',
                                  suffixStyle: const TextStyle(fontSize: 10),
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  GestureDetector(
                    onTap: (){
                      if (globlekey.currentState!.validate()) {
                        globlekey.currentState!.save();
                        if(double.parse(_minphController.text) > double.parse(_maxphController.text) || double.parse(_minECController.text) > double.parse(_maxECController.text)){
                          CherryToast.error(
                            toastDuration: const Duration(milliseconds: 1),
                            disableToastAnimation: true,
                            title: const Text(
                              'Invalid Input',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            action: const Text('Min < Max'),
                            inheritThemeColors: true,
                            actionHandler: () {},
                            onToastClosed: () {},
                          ).show(context);
                        }else{
                          Provider.of<VetegetableProvider>(context, listen: false)
                              .updatevegetable(widget.index, _nameController.text, _minphController.text, _maxphController.text, _minECController.text, _maxECController.text);
                          Navigator.of(context).pop();
                          CherryToast.success(
                            toastDuration: const Duration(milliseconds: 1),
                            disableToastAnimation: true,
                            title: const Text(
                              'Modify successful',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            inheritThemeColors: true,
                            actionHandler: () {},
                            onToastClosed: () {},
                          ).show(context);
                        }
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
                          action: const Text('Do not empty'),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                      child: const Center(
                        child: Text('Save'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateEmpty(String value) => value.isEmpty ? true : false;
}
