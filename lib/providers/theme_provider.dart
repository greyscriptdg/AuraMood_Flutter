import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'isDarkMode';
  bool _isDarkMode = false;
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;

  ThemeProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs?.getBool(_themeKey) ?? false;
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (!_isInitialized) return;
    
    _isDarkMode = !_isDarkMode;
    await _prefs?.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }
} 