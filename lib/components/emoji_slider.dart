import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;
import 'package:aura_mood_flutter/models/mood.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:aura_mood_flutter/utils/mood_data.dart';
import 'package:aura_mood_flutter/providers/theme_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:aura_mood_flutter/providers/theme_provider.dart';

class EmojiSlider extends StatefulWidget {
  const EmojiSlider({super.key});

  @override
  State<EmojiSlider> createState() => _EmojiSliderState();
}

class _EmojiSliderState extends State<EmojiSlider> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.65);
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();

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
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _glowController.dispose();
    _bounceController.dispose();
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _bounceController.forward(from: 0);
    _bounceController.forward(from: 0);
    HapticFeedback.lightImpact();
  }

  Future<void> _onEmojiSelected() async {
    final moodProvider = Provider.of<MoodProvider>(context, listen: false);
    final selectedMood = MoodData.moods[_selectedIndex];
    moodProvider.addMood(selectedMood);
    _confettiController.play();
    HapticFeedback.mediumImpact();
    await _audioPlayer.play(AssetSource('audio/success.mp3'));
  }

  Widget _buildLottieOrEmoji(Mood mood, bool isSelected) {
    final lottiePath = 'assets/lottie/${mood.name.toLowerCase()}.json';
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(lottiePath).catchError((_) => null),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Lottie.asset(
            lottiePath,
            width: isSelected ? 90 : 70,
            height: isSelected ? 90 : 70,
            repeat: true,
          );
        } else {
          return Text(
            mood.emoji,
            style: TextStyle(fontSize: isSelected ? 72 : 64),
            semanticsLabel: mood.name,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 260,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: MoodData.moods.length,
                itemBuilder: (context, index) {
                  final mood = MoodData.moods[index];
                  final isSelected = index == _selectedIndex;
                  final value = (_pageController.hasClients ? (_pageController.page ?? _selectedIndex) : _selectedIndex) - index;
                  final angle = value * 0.3;
                  final scale = (1 - value.abs() * 0.2).clamp(0.8, 1.0);

                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: scale,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: LinearGradient(
                            colors: [
                              mood.backgroundColor.withOpacity(isDarkMode ? 0.3 : 0.7),
                              mood.color.withOpacity(0.2),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: mood.color.withOpacity(0.4),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
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
                                      gradient: RadialGradient(
                                        colors: [
                                          mood.color.withOpacity(_glowAnimation.value),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    width: 120,
                                    height: 120,
                                  );
                                },
                              ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                border: isSelected
                                    ? Border.all(
                                        width: 3,
                                        color: Colors.white.withOpacity(0.7),
                                      )
                                    : null,
                                color: Colors.white.withOpacity(isDarkMode ? 0.08 : 0.18),
                                backgroundBlendMode: BlendMode.overlay,
                              ),
                              width: double.infinity,
                              height: double.infinity,
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
                                      child: _buildLottieOrEmoji(mood, isSelected),
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
                                  semanticsLabel: mood.name,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
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
        ),
        // Confetti
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: math.pi / 2,
            maxBlastForce: 20,
            minBlastForce: 8,
            emissionFrequency: 0.08,
            numberOfParticles: 20,
            gravity: 0.3,
            colors: [
              MoodData.moods[_selectedIndex].color,
              Colors.white,
              Colors.amber,
              Colors.pinkAccent,
            ],
          ),
        ),
      ],
    );
  }
} 