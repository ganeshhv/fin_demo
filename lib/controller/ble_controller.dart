import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BleController extends ChangeNotifier{
  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  static const platform = MethodChannel('bluetooth_channel');


  Future<void> enableBluetooth() async {
    try {
      final res = await platform.invokeMethod('enableBluetooth');

      print("channel res: $res");

      if(res == "enabled"){
        _isEnabled = true;
      }
      else{
        _isEnabled = false;
      }
    } catch (e) {
      print('Failed to enable Bluetooth: $e');
    }
    notifyListeners();
  }
}