import 'package:flutter/material.dart';
import 'package:aura_mood_flutter/models/mood.dart';

class MoodData {
  static final List<Mood> moods = [
    Mood(
      emoji: '😊',
      name: 'Happy',
      color: Colors.yellow.shade300,
      quote: 'Happiness is not something ready made. It comes from your own actions.',
    ),
    Mood(
      emoji: '😢',
      name: 'Sad',
      color: Colors.blue.shade300,
      quote: 'The way I see it, if you want the rainbow, you gotta put up with the rain.',
    ),
    Mood(
      emoji: '😡',
      name: 'Angry',
      color: Colors.red.shade300,
      quote: 'For every minute you remain angry, you give up sixty seconds of peace of mind.',
    ),
    Mood(
      emoji: '😴',
      name: 'Tired',
      color: Colors.grey.shade300,
      quote: 'Rest when you\'re weary. Refresh and renew yourself, your body, your mind, your spirit.',
    ),
    Mood(
      emoji: '😌',
      name: 'Calm',
      color: Colors.green.shade300,
      quote: 'Peace begins with a smile.',
    ),
    Mood(
      emoji: '😨',
      name: 'Anxious',
      color: Colors.purple.shade300,
      quote: 'You don\'t have to control your thoughts. You just have to stop letting them control you.',
    ),
    Mood(
      emoji: '😍',
      name: 'Excited',
      color: Colors.orange.shade300,
      quote: 'The only way to do great work is to love what you do.',
    ),
  ];
} 