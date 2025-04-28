import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_mood_flutter/models/mood.dart';
import 'package:aura_mood_flutter/providers/mood_provider.dart';
import 'package:intl/intl.dart';

class MoodHistoryList extends StatelessWidget {
  const MoodHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, moodProvider, child) {
        if (moodProvider.moods.isEmpty) {
          return const Center(
            child: Text('No mood history yet'),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: moodProvider.moods.length,
          itemBuilder: (context, index) {
            final mood = moodProvider.moods[index];
            return GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => MoodDetailModal(mood: mood),
              ),
              child: _MoodHistoryCard(mood: mood),
            );
          },
        );
      },
    );
  }
}

class _MoodHistoryCard extends StatelessWidget {
  final Mood mood;

  const _MoodHistoryCard({required this.mood});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: mood.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mood.emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Text(
            mood.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('MMM d').format(mood.timestamp),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class MoodDetailModal extends StatefulWidget {
  final Mood mood;
  const MoodDetailModal({super.key, required this.mood});

  @override
  State<MoodDetailModal> createState() => _MoodDetailModalState();
}

class _MoodDetailModalState extends State<MoodDetailModal> {
  late TextEditingController _noteController;
  String? _note;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.mood.note ?? '');
    _note = widget.mood.note;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                widget.mood.emoji,
                style: const TextStyle(fontSize: 48),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                widget.mood.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                DateFormat('MMM d, yyyy – h:mm a').format(widget.mood.timestamp),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.mood.quote,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _note = val),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                    onPressed: () {
                      // TODO: Save note to provider/model
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    onPressed: () {
                      // TODO: Delete mood from provider
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 