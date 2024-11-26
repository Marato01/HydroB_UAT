import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class BLEProvider extends ChangeNotifier {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription? _scanStream;
  StreamSubscription? _connectionStream;
  final List<DiscoveredDevice> _devices = [];
  final Set<String> _deviceIds = {};
  bool _isScanning = false;
  bool _isConnected = false;
  DiscoveredDevice? _selectedDevice;
  var serviceUuid;
  var characteristicUuid;

  int? latestNumber; // Variable to store the latest number

  // Getters
  List<DiscoveredDevice> get devices => _devices;
  bool get isScanning => _isScanning;
  bool get isConnected => _isConnected;
  DiscoveredDevice? get selectedDevice => _selectedDevice;
  Stream<List<int>>? characteristicValueStream;

  @override
  void dispose() {
    _scanStream?.cancel();
    _connectionStream?.cancel();
    super.dispose();
  }

  // Function scan device
  Future<void> startScan(BuildContext context) async {
    bool goForIt = false;

    if (Platform.isAndroid) {
      bool locationEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;

      if (!locationEnabled) {
        bool? dialogResult = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Enable Location Services"),
              content: const Text("Location services are disabled. Please enable them in settings."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    await Geolocator.openLocationSettings();
                  },
                  child: const Text("Go to Settings"),
                ),
              ],
            );
          },
        );

        // Check if location was enabled after returning from settings
        if (dialogResult == true) {
          // Wait for a moment to allow settings to update
          await Future.delayed(const Duration(seconds: 2));
          locationEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;

          // If still not enabled, show error message
          if (!locationEnabled) {
            throw Exception('Location services must be enabled to scan for BLE devices');
          }
        } else {
          // User cancelled, abort scan
          throw Exception('Location services are required to scan for BLE devices');
        }
      }

      int sdkInt = 0;
      try {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        sdkInt = androidInfo.version.sdkInt;
      } catch (e) {
        sdkInt = 31;
        debugPrint('Could not determine Android SDK version: $e');
      }

      if (sdkInt >= 31) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.bluetoothAdvertise,
          Permission.location,
          Permission.locationWhenInUse,
        ].request();

        goForIt = statuses.values.every((status) => status == PermissionStatus.granted);

        if (!goForIt) {
          String deniedPermissions = statuses.entries
              .where((entry) => entry.value != PermissionStatus.granted)
              .map((entry) => entry.key.toString())
              .join(', ');
          throw Exception('Required permissions not granted: $deniedPermissions');
        }
      } else {
        PermissionStatus locationPermission = await Permission.location.request();
        PermissionStatus finePermission = await Permission.locationWhenInUse.request();

        goForIt = locationPermission == PermissionStatus.granted &&
            finePermission == PermissionStatus.granted;

        if (!goForIt) {
          throw Exception('Location permission is required to scan for BLE devices');
        }
      }
    } else if (Platform.isIOS) {
      PermissionStatus bluetoothPermission = await Permission.bluetooth.request();
      goForIt = bluetoothPermission == PermissionStatus.granted;
    }

    if (goForIt) {
      _devices.clear();
      _deviceIds.clear();
      _isScanning = true;
      notifyListeners();

      _scanStream = flutterReactiveBle.scanForDevices(
        withServices: [],
        scanMode: ScanMode.balanced,
        requireLocationServicesEnabled: true,
      ).listen(
            (device) {
          if (device.name.isNotEmpty && !_deviceIds.contains(device.id)) {
            _deviceIds.add(device.id);
            _devices.add(device);
            notifyListeners();
          }
        },
        onError: (error) {
          debugPrint('Scanning error: $error');
          stopScan();
          throw Exception('Scanning error: $error');
        },
      );

      Future.delayed(const Duration(seconds: 30), () {
        if (_isScanning) {
          stopScan();
        }
      });
    }
  }

  // Function connect device
  Future<void> connectToDevice(DiscoveredDevice device) async {
    try {
      _isScanning = false;
      _selectedDevice = device;
      notifyListeners();
      stopScan();

      _connectionStream = flutterReactiveBle.connectToDevice(
        id: device.id,
        servicesWithCharacteristicsToDiscover: null,
        connectionTimeout: const Duration(seconds: 10),
      ).listen(
            (connectionState) async {
          debugPrint('Connection state: ${connectionState.connectionState}');
          if (connectionState.connectionState == DeviceConnectionState.connected) {
            _isConnected = true;
            //stream after connect device succesful
            readCharacteristic();
            notifyListeners();

            final services = await flutterReactiveBle.discoverServices(device.id);
            for (var service in services) {
              serviceUuid = service.serviceId;
              for (var characteristic in service.characteristics) {
                characteristicUuid = characteristic.characteristicId;
              }
            }
          } else {
            _isConnected = false;
            notifyListeners();
          }
        },
        onError: (error) {
          debugPrint('Connection error: $error');
          throw Exception('Connection error: $error');
        },
      );
    } catch (e) {
      debugPrint('Error connecting to device: $e');
      throw Exception('Error connecting to device: $e');
    }
  }

  // Function write value
  Future<void> writeCharacteristic(String message) async {
    if (_selectedDevice == null || !_isConnected) {
      throw Exception('No device connected');
    }

    try {
      final value = message.codeUnits;
      final characteristic = QualifiedCharacteristic(
        serviceId: serviceUuid,
        characteristicId: characteristicUuid,
        deviceId: _selectedDevice!.id,
      );

      await flutterReactiveBle.writeCharacteristicWithResponse(characteristic, value: value);
    } catch (e) {
      throw Exception('Error writing characteristic: $e');
    }
  }


  // Function read value
  Future<void> readCharacteristic() async {
    final box = await Hive.openBox<List<int>>('numberBox'); // Open the Hive box

    // Function to display stored numbers
    void displayStoredNumbers() {
      List<int> numbers = box.get('numbers', defaultValue: [])!;
      print('Stored numbers: $numbers');
    }

    // Periodically clear data every minute
    void startPeriodicDataClear() {
      Timer.periodic(const Duration(minutes: 10), (timer) {
        box.clear(); // Clear all stored data
        box.put('numbers', []); // Reset the box with an empty list
        print('All stored data cleared and reset every minute.');
      });
    }

    // Ensure a device is connected
    if (_selectedDevice == null || !_isConnected) {
      throw Exception('No device connected.');
    }

    try {
      // Discover services and characteristics
      final services = await flutterReactiveBle.discoverServices(_selectedDevice!.id);
      QualifiedCharacteristic? notifiableCharacteristic;

      // Find a notifiable characteristic
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.isNotifiable) {
            serviceUuid = service.serviceId;
            characteristicUuid = characteristic.characteristicId;

            notifiableCharacteristic = QualifiedCharacteristic(
              serviceId: serviceUuid,
              characteristicId: characteristicUuid,
              deviceId: _selectedDevice!.id,
            );
            break;
          }
        }
        if (notifiableCharacteristic != null) break;
      }

      // Throw exception if no notifiable characteristic is found
      if (notifiableCharacteristic == null) {
        throw Exception('No notifiable characteristic found.');
      }


      // Subscribe to the notifiable characteristic
      characteristicValueStream = flutterReactiveBle.subscribeToCharacteristic(notifiableCharacteristic);

      characteristicValueStream?.listen(
            (data) {
          final value = utf8.decode(data); // Decode bytes to UTF-8 string
          print('Received value: $value');

          int? number = int.tryParse(value); // Parse string into integer
          if (number != null) {
            // Add the number to Hive and update UI
            List<int> updatedNumbers = box.get('numbers', defaultValue: [])!;
            updatedNumbers.add(number);
            box.put('numbers', updatedNumbers);

            updateNumber(number); // Update provider with new number
            displayStoredNumbers(); // Display updated list
          }
        },
        onError: (error) {
          debugPrint('Error receiving notifications: $error');
        },
      );

      // Start periodic data clearing
      startPeriodicDataClear();

    } catch (e) {
      debugPrint('Error in readCharacteristic: $e');
      throw Exception('Error reading characteristic: $e');
    }
  }

  // Function to add a number to the provider
  void updateNumber(int number) {
    latestNumber = number;
    notifyListeners(); // Notify UI about the update
  }

  // function for disconnect
  void disconnect() {
    _connectionStream?.cancel();
    _isConnected = false;
    _selectedDevice = null;
    notifyListeners();
  }

  // function for stop scan
  void stopScan() {
    _scanStream?.cancel();
    _isScanning = false;
    notifyListeners();
  }
}

