import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/database/local_database_bloc.dart';
import '../../blocs/database/local_database_event.dart';
import '../../blocs/database/local_database_state.dart';
import '../../widgets/reminder_title.dart';
import '../../widgets/section_title.dart';
import '../../widgets/quick_access_button.dart';
import '../../widgets/screenshot_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocalDataBaseContentBloc>().add(
        FetchUserContent(limit: 10)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<LocalDataBaseContentBloc>().add(
                FetchUserContent(limit: 10)
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=47",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text("Synapse",
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SectionTitle(title: "Recent Content"),
                    BlocBuilder<LocalDataBaseContentBloc, ContentState>(
                      builder: (context, state) {
                        if (state is UserContentLoaded && state.contents.length > 8) {
                          return TextButton.icon(
                            onPressed: () {
                              _navigateToAllContent(context);
                            },
                            icon: const Icon(Icons.arrow_forward, size: 16),
                            label: const Text("View All"),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                BlocBuilder<LocalDataBaseContentBloc, ContentState>(
                  builder: (context, state) {
                    if (state is ContentLoading) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is UserContentLoaded) {
                      if (state.contents.isEmpty) {
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_library_outlined,
                                  size: 48,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "No content yet",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Share some content to see it here",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final displayItems = state.contents.take(6).toList();
                      final hasMoreItems = state.contents.length > 6;

                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hasMoreItems ? displayItems.length + 1 : displayItems.length,
                          itemBuilder: (context, index) {
                            if (index == displayItems.length && hasMoreItems) {
                              return _buildViewAllCard(context, state.contents.length);
                            }

                            final content = displayItems[index];
                            return ScreenshotCard(
                              content: content,
                            );
                          },
                        ),
                      );
                    } else if (state is LocalDataBaseContentError) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Error loading content",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.message,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<LocalDataBaseContentBloc>().add(
                                      FetchUserContent(limit: 10)
                                  );
                                },
                                child: Text("Retry"),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Default/Initial state
                      return SizedBox(
                        height: 300,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            Placeholder(),
                          ],
                        ),
                      );
                    }
                  },
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
                    QuickAccessButton(icon: Icons.calendar_today, label: "Calendar"),
                  ],
                ),
                const SizedBox(height: 20),

                // Upcoming Reminders (kept as is for now)
                const SectionTitle(title: "Upcoming Reminders"),
                const ReminderTile(title: "Meeting with Sophia", time: "10:00 AM"),
                const ReminderTile(title: "Project Deadline", time: "2:00 PM"),
                const ReminderTile(title: "Meeting with Sophia", time: "10:00 AM"),
                const ReminderTile(title: "Project Deadline", time: "2:00 PM"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewAllCard(BuildContext context, int totalCount) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => _navigateToAllContent(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.grid_view,
                    size: 32,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "View All",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "$totalCount items",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToAllContent(BuildContext context) {
    context.push('/screenshot_list_screen');
  }
}

// Create this new screen to show all content
