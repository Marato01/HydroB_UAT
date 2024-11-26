import 'package:flutter/material.dart';

class SetValueProvider with ChangeNotifier {
  String name = '';
  String minPh = '';
  String maxPh = '';
  String minEC = '';
  String maxEC = '';

  void updateValues(String name, String minPh, String maxPh, String minEC, String maxEC) {
    this.name = name;
    this.minPh = minPh;
    this.maxPh = maxPh;
    this.minEC = minEC;
    this.maxEC = maxEC;
    notifyListeners();
  }
}
