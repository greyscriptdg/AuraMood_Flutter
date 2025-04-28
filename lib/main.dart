import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/providers/theme_provider.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:aura_mood_flutter/screens/home_screen.dart';
import 'package:aura_mood_flutter/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aura_mood_flutter/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
      ],
      child: AuraMoodApp(onboardingComplete: onboardingComplete),
    ),
  );
}

class AuraMoodApp extends StatelessWidget {
  final bool onboardingComplete;
  const AuraMoodApp({super.key, required this.onboardingComplete});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'AuraMood',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Colors.purple.shade300,
              secondary: Colors.pink.shade200,
              surface: Colors.white,
              background: Colors.grey.shade50,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.dark(
              primary: Colors.purple.shade200,
              secondary: Colors.pink.shade100,
              surface: Colors.grey.shade900,
              background: Colors.grey.shade800,
            ),
            useMaterial3: true,
          ),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: onboardingComplete ? '/home' : '/onboarding',
          routes: {
            '/home': (context) => const HomeScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
          },
        );
      },
    );
  }
} 