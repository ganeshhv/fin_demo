import 'package:flutter/cupertino.dart';

import '../model/error_model.dart';
import 'api_service.dart';

class GetRandomImageController extends ChangeNotifier{
  String _image = "";
  String get image => _image;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorText;
  String get errorMsg => _errorText!;

  final _apiService = ApiService();

  void fetchRandomDogImage() async {
    _isLoading = true;
    notifyListeners();
    final res = await _apiService.fetchRandomDogImageApi();

    if(res.runtimeType == ErrorModel){
      ErrorModel _error = (res as ErrorModel);
      _errorText = _error.message;
    }
    else{
      _image = res;
    }
    _isLoading = false;
    notifyListeners();
  }

}