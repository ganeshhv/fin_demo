import 'package:fin/controller/api_service.dart';
import 'package:fin/model/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/error_model.dart';

class FetchUserController extends ChangeNotifier{
  User? _user;
  User? get getUser => _user;

  String _errorMsg = "";
  String get errorMsg => _errorMsg;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final _apiService = ApiService();

  Future fetchUserProfile() async {
    _isLoading = true;
    final res = await _apiService.fetchUserProfileApi();

    if(res.runtimeType == ErrorModel){
      ErrorModel _error = res as ErrorModel;
      _errorMsg = _error.message!;
    }
    else{
      _user = res as User;
    }
    _isLoading = false;
    notifyListeners();

  }

}