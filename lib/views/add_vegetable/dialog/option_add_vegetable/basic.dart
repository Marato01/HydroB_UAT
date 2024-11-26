import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/add_vegetable_provider.dart';

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {

  final List<String> items = List.generate(100, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items[index]),

                  GestureDetector(
                    onTap: () {
                      if (!Provider.of<VetegetableProvider>(context, listen: false).isVegetableAdded(items[index].toString())) {
                        Provider.of<VetegetableProvider>(context, listen: false).addVegetable(
                          items[index].toString(),
                          items[index].toString(),
                          items[index].toString(),
                          items[index].toString(),
                          items[index].toString(),
                        );
                      }
                    },
                    child: Consumer<VetegetableProvider>(
                      builder: (context, provider, child) {
                        bool isAdded = provider.isVegetableAdded(items[index].toString());
                        return Icon(isAdded ? Icons.done : Icons.add_circle_outline_outlined);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
      ),
    );
  }
}
