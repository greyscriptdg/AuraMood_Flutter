import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 20, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _reminderEnabled = prefs.getBool('reminder_enabled') ?? false;
      final hour = prefs.getInt('reminder_hour') ?? 20;
      final minute = prefs.getInt('reminder_minute') ?? 0;
      _reminderTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  Future<void> _updateReminder(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _reminderEnabled = enabled);
    await prefs.setBool('reminder_enabled', enabled);
    if (enabled) {
      await NotificationService.scheduleDailyReminder(_reminderTime.hour, _reminderTime.minute);
    } else {
      await NotificationService.cancelReminder();
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null) {
      setState(() => _reminderTime = picked);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('reminder_hour', picked.hour);
      await prefs.setInt('reminder_minute', picked.minute);
      if (_reminderEnabled) {
        await NotificationService.scheduleDailyReminder(picked.hour, picked.minute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Daily Mood Reminder'),
            value: _reminderEnabled,
            onChanged: _updateReminder,
          ),
          ListTile(
            title: const Text('Reminder Time'),
            subtitle: Text(_reminderTime.format(context)),
            enabled: _reminderEnabled,
            onTap: _reminderEnabled ? _pickTime : null,
            trailing: const Icon(Icons.access_time),
          ),
        ],
      ),
    );
  }
} 