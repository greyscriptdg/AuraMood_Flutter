import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/providers/theme_provider.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: theme.colorScheme.primary,
      ),
      onPressed: () {
        themeProvider.toggleTheme();
        HapticFeedback.lightImpact();
      },
      tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
    );
  }
} 