import 'package:flutter/material.dart';
import '../../widgets/reminder_title.dart';
import '../../widgets/section_title.dart';
import '../../widgets/quick_access_button.dart';
import '../../widgets/screenshot_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile + Title
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=47", // sample image
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text("Synapse",
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 20),



              // Recent Screenshots
              const SectionTitle(title: "Recent Screenshots"),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ScreenshotCard(title: "Website", imageUrl: "https://placehold.co/800x800/png"),
                    ScreenshotCard(title: "Document", imageUrl: "https://placehold.co/800x400/png"),
                    ScreenshotCard(title: "Presentation", imageUrl: "https://placehold.co/600x400/png"),
                    ScreenshotCard(title: "Website", imageUrl: "https://placehold.co/600x400/png"),
                    ScreenshotCard(title: "Document", imageUrl: "https://placehold.co/600x400/png"),
                    ScreenshotCard(title: "Presentation", imageUrl: "https://placehold.co/600x400/png"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Quick Access
              const SectionTitle(title: "Quick Access"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  QuickAccessButton(icon: Icons.image, label: "Capture"),
                  QuickAccessButton(icon: Icons.account_tree, label: "Mind Map"),
                  QuickAccessButton(icon: Icons.calendar_today, label: "Calendar"),
                ],
              ),
              const SizedBox(height: 20),

              // Upcoming Reminders
              const SectionTitle(title: "Upcoming Reminders"),
              const ReminderTile(title: "Meeting with Sophia", time: "10:00 AM"),
              const ReminderTile(title: "Project Deadline", time: "2:00 PM"),
            ],
          ),
        ),
      ),
    );
  }
}
