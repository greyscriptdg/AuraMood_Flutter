import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/models/mood.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:aura_mood_flutter/utils/mood_data.dart';
import 'package:aura_mood_flutter/providers/theme_provider.dart';

class EmojiSlider extends StatefulWidget {
  const EmojiSlider({super.key});

  @override
  State<EmojiSlider> createState() => _EmojiSliderState();
}

class _EmojiSliderState extends State<EmojiSlider> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _glowController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _bounceController.forward(from: 0);
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 240,
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
                  color: isDarkMode 
                      ? mood.backgroundColor.withOpacity(0.2)
                      : mood.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? Border.all(
                          color: mood.color,
                          width: 2,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: mood.color.withOpacity(isDarkMode ? 0.1 : 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isSelected)
                      AnimatedBuilder(
                        animation: _glowAnimation,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mood.color.withOpacity(_glowAnimation.value),
                            ),
                            width: 120,
                            height: 120,
                          );
                        },
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: _bounceAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: isSelected ? _bounceAnimation.value : 1.0,
                              child: Text(
                                mood.emoji,
                                style: TextStyle(
                                  fontSize: isSelected ? 72 : 64,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          mood.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                                color: isDarkMode ? Colors.white : mood.textColor,
                                fontSize: 28,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                letterSpacing: 0.5,
                              ),
                        ),
                        const SizedBox(height: 20),
                      ],
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
                    : isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: MoodData.moods[_selectedIndex].color.withOpacity(isDarkMode ? 0.2 : 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _onEmojiSelected,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: MoodData.moods[_selectedIndex].color,
              foregroundColor: isDarkMode ? Colors.white : MoodData.moods[_selectedIndex].textColor,
              elevation: 5,
            ),
            child: const Text(
              'Select Mood',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
} 