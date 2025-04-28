import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';

class AuraBackground extends StatelessWidget {
  const AuraBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, moodProvider, child) {
        final currentMood = moodProvider.currentMood;
        
        if (currentMood == null) {
          return const SizedBox.shrink();
        }

        return Positioned.fill(
          child: Opacity(
            opacity: 0.3,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                currentMood.color,
                BlendMode.srcIn,
              ),
              child: Lottie.asset(
                'assets/lottie/aura_background.json',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
} 