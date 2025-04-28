# AuraMood Flutter

A beautiful mood tracking app built with Flutter that helps you track your emotions and provides motivational quotes.

## Features

- 🎨 Light/Dark theme support
- 😊 Emoji mood selection with smooth animations
- 💫 Animated aura background
- 📜 Motivational quotes based on selected mood
- 📱 Clean, modern UI
- 📊 Recent mood history tracking
- 📱 Haptic feedback for better user experience

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/aura_mood_flutter.git
```

2. Navigate to the project directory:
```bash
cd aura_mood_flutter
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
aura_mood_flutter/
├── assets/
│   └── lottie/
│       └── aura_background.json
├── lib/
│   ├── components/
│   │   ├── aura_background.dart
│   │   ├── emoji_slider.dart
│   │   ├── mood_card.dart
│   │   ├── mood_history_list.dart
│   │   └── theme_toggle.dart
│   ├── models/
│   │   └── mood.dart
│   ├── providers/
│   │   ├── mood_provider.dart
│   │   └── theme_provider.dart
│   ├── screens/
│   │   └── home_screen.dart
│   ├── utils/
│   │   └── mood_data.dart
│   └── main.dart
```

## Dependencies

- `provider`: State management
- `lottie`: Beautiful animations
- `flutter_hooks`: Clean stateful widgets
- `haptic_feedback`: Haptic feedback
- `shared_preferences`: Local storage
- `intl`: Date formatting

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 