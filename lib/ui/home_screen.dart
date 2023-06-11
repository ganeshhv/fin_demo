import 'package:fin/ui/profile_screen.dart';
import 'package:fin/ui/random_image_generator.dart';
import 'package:flutter/material.dart';

import 'bluetooth_screen.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                gotoScreen(context, RandomImagesScreen());
              },
              child: Text('Random Dog Image'),
            ),
            ElevatedButton(
              onPressed: (){
                gotoScreen(context, EnableBluetoothScreen());
              },
              child: Text('Bluetooth'),
            ),
            ElevatedButton(
              onPressed: (){
                gotoScreen(context, ProfileScreen());
              },
              child: Text('Get User Data '),
            ),
          ],
        ),
      ),
    );
  }

  gotoScreen(BuildContext context, screenName){
    Navigator.push(context, MaterialPageRoute(builder: (_) => screenName));
  }
}
