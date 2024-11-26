import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageProvider extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  // Key for storing the image path in SharedPreferences
  static const String _profileImageKey = 'profile_image_path';

  ProfileImageProvider() {
    _loadImageFromPreferences();  // Load image path when provider is initialized
  }

  // Load image path from SharedPreferences
  Future<void> _loadImageFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _imagePath = prefs.getString(_profileImageKey);  // Retrieve stored image path
    notifyListeners();  // Notify listeners to rebuild UI
  }

  // Set image and save the path to SharedPreferences
  Future<void> setImage(String path) async {
    _imagePath = path;
    notifyListeners();  // Notify consumers of change

    // Save image path to SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);  // Store image path
  }

  // Method to load image for CircleAvatar
  ImageProvider<Object> loadImage() {
    if (_imagePath != null) {
      return FileImage(File(_imagePath!));  // Load image from file
    } else {
      return const AssetImage('assets/images/default_profile.png');  // Placeholder image
    }
  }
}
