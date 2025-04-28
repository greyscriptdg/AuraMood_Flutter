import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/components/aura_background.dart';
import 'package:aura_mood_flutter/components/emoji_slider.dart';
import 'package:aura_mood_flutter/components/mood_history_list.dart';
import 'package:aura_mood_flutter/components/theme_toggle.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:aura_mood_flutter/screens/settings_screen.dart';
import 'package:aura_mood_flutter/screens/mood_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AuraMood',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          const ThemeToggle(),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          const AuraBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'How are you feeling today?',
                      style: TextStyle(
                        fontSize: 28,
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
                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: moodProvider.currentMood!.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: moodProvider.currentMood!.color.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              moodProvider.currentMood!.quote,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 18,
                                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
                                    fontStyle: FontStyle.italic,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Recent Moods',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.show_chart),
                      label: const Text('View Mood History'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const MoodHistoryScreen()),
                        );
                      },
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
          ),
        ],
      ),
    );
  }
} 