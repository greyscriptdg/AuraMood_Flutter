import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/models/mood.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:intl/intl.dart';

class MoodHistoryList extends StatelessWidget {
  const MoodHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, moodProvider, child) {
        if (moodProvider.moods.isEmpty) {
          return const Center(
            child: Text('No mood history yet'),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: moodProvider.moods.length,
          itemBuilder: (context, index) {
            final mood = moodProvider.moods[index];
            return _MoodHistoryCard(mood: mood);
          },
        );
      },
    );
  }
}

class _MoodHistoryCard extends StatelessWidget {
  final Mood mood;

  const _MoodHistoryCard({required this.mood});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: mood.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mood.emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Text(
            mood.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('MMM d').format(mood.timestamp),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
} 