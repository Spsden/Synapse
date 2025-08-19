import 'package:flutter/material.dart';

class ReminderTile extends StatelessWidget {
  final String title;
  final String time;

  const ReminderTile({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.notifications, color: Colors.white),
      title: Text(title),
      subtitle: Text(time, style: const TextStyle(color: Colors.grey)),
    );
  }
}
