import 'package:flutter/material.dart';

class Mood {
  final String emoji;
  final String name;
  final Color color;
  final Color backgroundColor;
  final Color textColor;
  final String quote;
  final DateTime timestamp;

  Mood({
    required this.emoji,
    required this.name,
    required this.color,
    required this.backgroundColor,
    required this.textColor,
    required this.quote,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'name': name,
        'color': color.value,
        'backgroundColor': backgroundColor.value,
        'textColor': textColor.value,
        'quote': quote,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
        emoji: json['emoji'],
        name: json['name'],
        color: Color(json['color']),
        backgroundColor: Color(json['backgroundColor']),
        textColor: Color(json['textColor']),
        quote: json['quote'],
        timestamp: DateTime.parse(json['timestamp']),
      );
} 