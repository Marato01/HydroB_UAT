import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/add_vegetable_provider.dart';

class Advance extends StatefulWidget {
  const Advance({super.key});

  @override
  State<Advance> createState() => _AdvanceState();
}

class _AdvanceState extends State<Advance> {

  var globlekey = GlobalKey<FormState>();

  //this is controller of each box
  var vegetablenameController = TextEditingController();
  var minphController = TextEditingController();
  var maxphController = TextEditingController();
  var minECController = TextEditingController();
  var maxECController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: globlekey,
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Vegetable',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFF00712D),
                        fontFamily: 'lato'),
                  ),
                ),
              ),

              SizedBox(width: MediaQuery.of(context).size.width * 0.05),

              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.withOpacity(0.50),
                  ),
                  child: TextFormField(
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
                    controller: vegetablenameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none)),
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
                      child: Text(
                        'Min pH',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFF00712D),
                            fontFamily: 'lato'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.withOpacity(0.50),
                      ),
                      child: TextFormField(
                        controller: minphController,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                        ),
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
                      child: Text(
                        'Max pH',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFF00712D),
                          fontFamily: 'lato',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.withOpacity(0.50),
                      ),
                      child: TextFormField(
                        controller: maxphController,
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(fontSize: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none)),
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
                      child: Text(
                        'Min EC',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFF00712D),
                            fontFamily: 'lato'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.withOpacity(0.50),
                      ),
                      child: TextFormField(
                        controller: minECController,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          suffixText: 'mS/m',
                          suffixStyle: const TextStyle(fontSize: 10),
                        ),
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
                      child: Text(
                        'Max EC',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFF00712D),
                            fontFamily: 'lato'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.withOpacity(0.50),
                      ),
                      child: TextFormField(
                        controller: maxECController,

                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          suffixText: 'mS/m',
                          suffixStyle: const TextStyle(fontSize: 10),
                        ),
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
            onTap: () {
              if (globlekey.currentState!.validate()) {
                globlekey.currentState!.save();
                if (double.parse(minphController.text) > double.parse(maxphController.text) || double.parse(minECController.text) > double.parse(maxECController.text)) {
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
                } else {
                  Provider.of<VetegetableProvider>(context,
                      listen: false)
                      .addVegetable(
                      vegetablenameController.text,
                      minphController.text,
                      maxphController.text,
                      minECController.text,
                      maxECController.text);
                  Navigator.of(context).pop();
                  CherryToast.success(
                    toastDuration: const Duration(milliseconds: 1),
                    disableToastAnimation: true,
                    title: const Text(
                      'Add successful',
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
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green),
              child: const Center(
                child: Text(
                  'Add',
                  style: TextStyle(fontFamily: 'lato'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  bool validateEmpty(String value) => value.isEmpty ? true : false;
}
