import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/get_random_image_controller.dart';

class RandomImagesScreen extends StatefulWidget {
  const RandomImagesScreen({super.key});

  @override
  _RandomImagesScreenState createState() => _RandomImagesScreenState();
}

class _RandomImagesScreenState extends State<RandomImagesScreen> {

  GetRandomImageController? _getRandomImageController;

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _getRandomImageController = Provider.of<GetRandomImageController>(context, listen: false);
    getImage();
  }

  getImage() async{
    if(!_getRandomImageController!.isLoading){
      _getRandomImageController!.fetchRandomDogImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dog Images'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getImage,
              child: Text('Refresh'),
            ),
            SizedBox(height: 16),
            Consumer<GetRandomImageController>(
                builder: (_, data, child){
                  print("data.isLoading: ${data.isLoading}");
                  if(data.isLoading){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if(data.image.isNotEmpty){
                    return Image.network(data.image);
                  }
                  return SizedBox();
                }
            )
          ],
        ),
      ),
    );
  }
}
