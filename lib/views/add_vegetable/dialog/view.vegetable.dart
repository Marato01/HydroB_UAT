import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewVegetable extends StatefulWidget {
  final String namevegetable;
  final String minph;
  final String maxph;
  final String minEC;
  final String maxEC;

  const ViewVegetable(
      {super.key,
      required this.namevegetable,
      required this.minph,
      required this.maxph,
      required this.minEC,
      required this.maxEC});

  @override
  State<ViewVegetable> createState() => _ViewVegetableState();
}

class _ViewVegetableState extends State<ViewVegetable> {
  late TextEditingController _nameController;
  late TextEditingController _minphController;
  late TextEditingController _maxphController;
  late TextEditingController _minECController;
  late TextEditingController _maxECController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.namevegetable);
    _minphController = TextEditingController(text: widget.minph);
    _maxphController = TextEditingController(text: widget.maxph);
    _minECController = TextEditingController(text: widget.minEC);
    _maxECController = TextEditingController(text: widget.maxEC);
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
              child: Text(
                'View Vegetable',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Color(0xFFF00712D),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Vegetable',
                  style: TextStyle(color: Color(0xFFF00712D)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text(_nameController.text)),
                ),
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text(
                        'Min pH',
                        style: TextStyle(color: Color(0xFFF00712D)),
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.50),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text(_minphController.text)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Center(
                      child: Text('Max pH',
                          style: TextStyle(color: Color(0xFFF00712D))),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.50),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Text(_maxphController.text)),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text('Min EC',
                          style: TextStyle(color: Color(0xFFF00712D))),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.50),
                          borderRadius: BorderRadius.circular(20)),
                      //_minECController.text
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_minECController.text),
                            const SizedBox(width: 5,),
                            const Text(
                              'mS/m',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Center(
                      child: Text('Max EC',
                          style: TextStyle(color: Color(0xFFF00712D))),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.50),
                          borderRadius: BorderRadius.circular(20)),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_maxECController.text),
                          const SizedBox(width: 5,),
                          const Text(
                            'mS/m',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
