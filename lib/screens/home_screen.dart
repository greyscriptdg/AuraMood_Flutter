import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/components/aura_background.dart';
import 'package:aura_mood_flutter/components/emoji_slider.dart';
import 'package:aura_mood_flutter/components/mood_history_list.dart';
import 'package:aura_mood_flutter/components/theme_toggle.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuraMood'),
        actions: const [ThemeToggle()],
      ),
      body: Stack(
        children: [
          const AuraBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  const EmojiSlider(),
                  const SizedBox(height: 32),
                  Consumer<MoodProvider>(
                    builder: (context, moodProvider, child) {
                      if (moodProvider.currentMood != null) {
                        return Column(
                          children: [
                            Text(
                              moodProvider.currentMood!.quote,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const Text(
                    'Recent Moods',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    height: 120,
                    child: MoodHistoryList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 