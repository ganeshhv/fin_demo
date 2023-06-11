import 'package:fin/controller/ble_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EnableBluetoothScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Enable Bluetooth'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: Provider.of<BleController>(context, listen: false).enableBluetooth,
          child: Consumer<BleController>(
              builder: (_, data, child){
                return !data.isEnabled ? Text('Enable Bluetooth') : Text('Disable Bluetooth');
              }
          ),
        ),
      ),
    );
  }
}
