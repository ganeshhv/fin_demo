import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import '../controller/fetch_user_controller.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final http.Client? httpClient;
  const ProfileScreen({super.key, this.httpClient});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  getUserProfile(){
    Provider.of<FetchUserController>(context, listen: false).fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer<FetchUserController>(
        builder: (_, data, child){
          if(data.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(data.errorMsg.isNotEmpty){
            return Center(
              child: Text(data.errorMsg,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          else if(data.getUser != null){
            User user = data.getUser!;
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(user.results!.name!.first! + ' ' + user.results!.name!.last!),
                ),
                ListTile(
                  title: Text('Location'),
                  subtitle: Text(user.results!.location?.country ?? ''),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(user.results?.email ?? ''),
                ),
                ListTile(
                  title: Text('Date of Birth'),
                  subtitle: Text(user.results?.dob?.date ?? ''),
                ),
                ListTile(
                  title: Text('Days Passed Since Registered'),
                  subtitle: Text(user.results?.registered?.age.toString() ?? ''),
                ),
                ListTile(
                  title: Text('Image'),
                  subtitle: Image.network(user.results!.picture?.large ?? ''),
                ),
              ],
            );
          }
          return SizedBox();
        },
      )
    );
  }
}
