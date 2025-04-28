import 'package:flutter/material.dart';
import 'package:aura_mood_flutter/models/mood.dart';

class MoodData {
  static final List<Mood> moods = [
    Mood(
      emoji: '😊',
      name: 'Happy',
      color: const Color(0xFFFFEB3B), // bright yellow
      backgroundColor: const Color(0xFFFFF9C4), // light warm yellow
      textColor: const Color(0xFF333333), // dark text
      quote: 'Happiness is not something ready made. It comes from your own actions.',
    ),
    Mood(
      emoji: '😢',
      name: 'Sad',
      color: const Color(0xFF64B5F6), // medium blue
      backgroundColor: const Color(0xFFBBDEFB), // soft sky blue
      textColor: const Color(0xFF0D47A1), // deep blue text
      quote: 'The way I see it, if you want the rainbow, you gotta put up with the rain.',
    ),
    Mood(
      emoji: '😡',
      name: 'Angry',
      color: const Color(0xFFEF5350), // red button
      backgroundColor: const Color(0xFFFFCDD2), // soft red-pink
      textColor: const Color(0xFFC62828), // bold dark red
      quote: 'For every minute you remain angry, you give up sixty seconds of peace of mind.',
    ),
    Mood(
      emoji: '😴',
      name: 'Tired',
      color: const Color(0xFFBDBDBD), // muted gray button
      backgroundColor: const Color(0xFFE0E0E0), // very soft gray
      textColor: const Color(0xFF424242), // dark gray text
      quote: 'Rest when you\'re weary. Refresh and renew yourself, your body, your mind, your spirit.',
    ),
    Mood(
      emoji: '😌',
      name: 'Calm',
      color: const Color(0xFF81C784), // soft green
      backgroundColor: const Color(0xFFC8E6C9), // mint green
      textColor: const Color(0xFF2E7D32), // rich green text
      quote: 'Peace begins with a smile.',
    ),
    Mood(
      emoji: '😨',
      name: 'Anxious',
      color: const Color(0xFFBA68C8), // bright lilac button
      backgroundColor: const Color(0xFFE1BEE7), // lavender purple
      textColor: const Color(0xFF6A1B9A), // bold purple text
      quote: 'You don\'t have to control your thoughts. You just have to stop letting them control you.',
    ),
    Mood(
      emoji: '😍',
      name: 'Excited',
      color: const Color(0xFFFF9800), // vibrant orange
      backgroundColor: const Color(0xFFFFE0B2), // warm orange
      textColor: const Color(0xFFE65100), // deep orange text
      quote: 'The only way to do great work is to love what you do.',
    ),
  ];
} 