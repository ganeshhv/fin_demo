import 'package:fin/controller/fetch_user_controller.dart';
import 'package:fin/controller/get_random_image_controller.dart';
import 'package:fin/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/ble_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GetRandomImageController()),
          ChangeNotifierProvider(create: (_) => FetchUserController()),
          ChangeNotifierProvider(create: (_) => BleController())
        ],
      child: MaterialApp(
        title: 'FinInfo Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'FinInfo Demo'),
      ),
    );
  }
}
 class MyHomePage extends StatelessWidget {
  final String title;
   const MyHomePage({Key? key, required this.title}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(title),
         centerTitle: true,
       ),
       body: HomeScreen(title: title,),
     );
   }
 }

