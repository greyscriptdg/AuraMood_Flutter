import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aura_mood_flutter/models/mood.dart';

class MoodProvider with ChangeNotifier {
  static const String _moodsKey = 'moods_history';
  late SharedPreferences _prefs;
  List<Mood> _moods = [];
  Mood? _currentMood;

  List<Mood> get moods => List.unmodifiable(_moods);
  Mood? get currentMood => _currentMood;

  MoodProvider() {
    _loadMoods();
  }

  Future<void> _loadMoods() async {
    _prefs = await SharedPreferences.getInstance();
    final moodsJson = _prefs.getStringList(_moodsKey);
    if (moodsJson != null) {
      _moods = moodsJson
          .map((jsonStr) => Mood.fromJson(json.decode(jsonStr)))
          .toList();
      _moods.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      if (_moods.isNotEmpty) {
        _currentMood = _moods.first;
      }
      notifyListeners();
    }
  }

  Future<void> addMood(Mood mood) async {
    _moods.insert(0, mood);
    _currentMood = mood;
    
    // Keep only the last 5 moods
    if (_moods.length > 5) {
      _moods = _moods.sublist(0, 5);
    }

    final moodsJson = _moods.map((m) => json.encode(m.toJson())).toList();
    await _prefs.setStringList(_moodsKey, moodsJson);
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _moods = [];
    _currentMood = null;
    await _prefs.remove(_moodsKey);
    notifyListeners();
  }
} 