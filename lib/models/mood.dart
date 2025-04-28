import 'package:flutter/material.dart';

class Mood {
  final String emoji;
  final String name;
  final Color color;
  final String quote;
  final DateTime timestamp;

  Mood({
    required this.emoji,
    required this.name,
    required this.color,
    required this.quote,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'name': name,
        'color': color.value,
        'quote': quote,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
        emoji: json['emoji'],
        name: json['name'],
        color: Color(json['color']),
        quote: json['quote'],
        timestamp: DateTime.parse(json['timestamp']),
      );
} 