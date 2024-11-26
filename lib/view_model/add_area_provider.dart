import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../views/add_area/model/name_area.dart';

class AddAreaProvider with ChangeNotifier {
  List<NameArea> _area = [];

  List<NameArea> get area => _area;

  AddAreaProvider() {
    loadAreas();  // Load areas from SharedPreferences on initialization
  }

  Future<void> loadAreas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaList = prefs.getString('areaList');
    if (areaList != null) {
      List<dynamic> jsonList = json.decode(areaList);
      _area = jsonList.map((item) => NameArea.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveAreas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonList = json.encode(_area.map((item) => item.toJson()).toList());
    await prefs.setString('areaList', jsonList);
  }

  void addArea(String namelocation) {
    _area.add(NameArea(namelocation));
    _saveAreas();  // Save areas to SharedPreferences
    notifyListeners();
  }

  NameArea getArea(int index) {
    return _area[index];
  }

  void updateArea(int index, String newArea) {
    _area[index].names = newArea;
    _saveAreas();  // Save changes to SharedPreferences
    notifyListeners();
  }

  void removearea(int index) {
    _area.removeAt(index);
    _saveAreas();  // Save changes to SharedPreferences
    notifyListeners();
  }

  String _data = "";

  String get data => _data;

  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}
