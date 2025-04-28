import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/providers/theme_provider.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:aura_mood_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
      ],
      child: const AuraMoodApp(),
    ),
  );
}

class AuraMoodApp extends StatelessWidget {
  const AuraMoodApp({super.key});

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
          home: const HomeScreen(),
        );
      },
    );
  }
} 