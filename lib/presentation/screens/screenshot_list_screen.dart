import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/database/local_database_bloc.dart';
import '../blocs/database/local_database_event.dart';
import '../blocs/database/local_database_state.dart';
import '../widgets/screenshot_card.dart';


class ScreenShotListScreen extends StatefulWidget {
  const ScreenShotListScreen({super.key});

  @override
  State<ScreenShotListScreen> createState() => _ScreenShotListScreenState();
}

class _ScreenShotListScreenState extends State<ScreenShotListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch all content
    context.read<LocalDataBaseContentBloc>().add(
        FetchUserContent(limit: 100) // Fetch more items
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Content"),
        elevation: 0,
      ),
      body: BlocBuilder<LocalDataBaseContentBloc, ContentState>(
        builder: (context, state) {
          if (state is ContentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserContentLoaded) {
            if (state.contents.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No content yet",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.contents.length,
              itemBuilder: (context, index) {
                final content = state.contents[index];
                return ScreenshotCard(content: content);
              },
            );
          } else if (state is LocalDataBaseContentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Error loading content",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocalDataBaseContentBloc>().add(
                          FetchUserContent(limit: 100)
                      );
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}