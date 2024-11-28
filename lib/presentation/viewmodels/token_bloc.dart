import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenBloc with ChangeNotifier {
  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  Future<void> loadToken() async {

    _isLoading = true;

    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _token = token;
    notifyListeners();
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = null;
    notifyListeners();
  }
}
