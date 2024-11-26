import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/add_vegetable/model/name_vegetable.dart';

class VetegetableProvider with ChangeNotifier {
  List<Vegetable> _item = [];

  List<Vegetable> get item => _item;


  // Load items from SharedPreferences
  Future<void> loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedItems = prefs.getStringList('myList');

    if (savedItems != null) {
      // Convert JSON string back into Vegetable objects
      _item = savedItems
          .map((item) => Vegetable.fromJson(json.decode(item)))
          .toList();
      notifyListeners();
    }
  }

  Future <void> addVegetable(String name, String minpH, String maxpH, String minEC, String maxEC) async{
    _item.add(Vegetable(name, minpH, maxpH, minEC, maxEC));
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert Vegetable objects to JSON strings
    List<String> stringList = _item.map((veg) => json.encode(veg.toJson())).toList();
    prefs.setStringList('myList', stringList);
  }


  Vegetable getVegetable(int index) {
    return _item[index];
  }

  void updatevegetable(int index, String newName, String minpH, String maxpH, String minEC, String maxEC){
   _item[index].name = newName;
   _item[index].minpH = minpH;
   _item[index].maxpH = maxpH;
   _item[index].minEC = minEC;
   _item[index].maxEC = maxEC;
    notifyListeners();
  }


  Future <void> removeVegetable(int index) async{
    _item.removeAt(index);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert Vegetable objects to JSON strings
    List<String> stringList = _item.map((veg) => json.encode(veg.toJson())).toList();
    prefs.setStringList('myList', stringList);
  }

  bool isVegetableAdded(String name) {
    return _item.any((vegetable) => vegetable.name == name);
  }
}