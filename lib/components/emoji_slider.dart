import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/models/mood.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:aura_mood_flutter/utils/mood_data.dart';

class EmojiSlider extends StatefulWidget {
  const EmojiSlider({super.key});

  @override
  State<EmojiSlider> createState() => _EmojiSliderState();
}

class _EmojiSliderState extends State<EmojiSlider> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    HapticFeedback.lightImpact();
  }

  void _onEmojiSelected() {
    final moodProvider = Provider.of<MoodProvider>(context, listen: false);
    final selectedMood = MoodData.moods[_selectedIndex];
    moodProvider.addMood(selectedMood);
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: MoodData.moods.length,
            itemBuilder: (context, index) {
              final mood = MoodData.moods[index];
              final isSelected = index == _selectedIndex;
              
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: mood.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? Border.all(
                          color: mood.color,
                          width: 2,
                        )
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mood.emoji,
                      style: TextStyle(
                        fontSize: isSelected ? 72 : 64,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mood.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: mood.color,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            MoodData.moods.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == _selectedIndex
                    ? MoodData.moods[index].color
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _onEmojiSelected,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: MoodData.moods[_selectedIndex].color,
          ),
          child: const Text(
            'Select Mood',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
} 