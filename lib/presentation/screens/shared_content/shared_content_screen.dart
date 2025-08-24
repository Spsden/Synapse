import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapse/data/data_sources/local/database/database.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_bloc.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_event.dart';

import '../../../core/domain/entities/shared_attachment.dart';
import '../../blocs/app_router/app_router_bloc.dart';
import '../../blocs/database/local_database_bloc.dart';
import '../../blocs/database/local_database_event.dart';
import '../../blocs/database/local_database_state.dart';
import '../../blocs/shared_content/shared_content_state.dart';
import '../../widgets/mic_recorder_button.dart';
import '../memory_success_screen.dart';

class SharedContentScreen extends StatefulWidget {
  const SharedContentScreen({super.key});

  @override
  State<SharedContentScreen> createState() => _SharedContentScreenState();
}

class _SharedContentScreenState extends State<SharedContentScreen> {
  final TextEditingController _controller = TextEditingController();
  void Function(int)? _updateAnimationState;

  @override
  void initState() {
    super.initState();
    context.read<SharedContentBloc>().add(SharedContentInitialize());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocalDataBaseContentBloc, ContentState>(
      listener: (context, state) {
        if (state is ContentInserted) {
          // Success - trigger success animation (1)
          _updateAnimationState?.call(1);
          if (kDebugMode) {
            print("Successfully added to DB with ID: ${state.insertedId}");
          }
        } else if (state is LocalDataBaseContentError) {
          // Failure - trigger failure animation (0)
          _updateAnimationState?.call(0);
          if (kDebugMode) {
            print("Failed to add to DB: ${state.message}");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Synapse: Capture',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<SharedContentBloc, SharedContentState>(
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(SharedContentState state) {
    switch (state.runtimeType) {
      case SharedContentInitial:
        return const Center(child: Text('Initializing...'));

      case SharedContentInitializing:
        return const Center(child: CircularProgressIndicator());

      case SharedContentReady:
        return const Center(child: Text('Ready to receive shared content'));

      case SharedContentReceiving:
        final receivingState = state as SharedContentReceiving;
        return _buildContentDisplay(receivingState.content);

      case SharedContentReceived:
        final receivedState = state as SharedContentReceived;
        return _buildContentDisplay(receivedState.content);

      case SharedContentDisplaying:
        final displayingState = state as SharedContentDisplaying;
        return _buildContentDisplay(displayingState.content);

      case SharedContentError:
        final errorState = state as SharedContentError;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Error: ${errorState.message}'),
            if (errorState.content != null) ...[
              const SizedBox(height: 16),
              _buildContentDisplay(errorState.content!),
            ],
          ],
        );

      default:
        return const Center(child: Text('Unknown state'));
    }
  }

  Widget _buildContentDisplay(dynamic content) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (content.attachments.isNotEmpty)
            Expanded(
              child: ListView(
                children: content.attachments
                    .map<Widget>(
                      (attachment) => _buildAttachmentWidget(attachment),
                )
                    .toList(),
              ),
            ),
          const SizedBox(height: 16),
          _buildActionArea(content),
        ],
      ),
    );
  }

  Widget _buildAttachmentWidget(dynamic attachment) {
    final path = attachment.path;
    if (path != null && attachment.type == SharedAttachmentType.image) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(File(path), fit: BoxFit.cover),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text("${attachment.type} Attachment: ${attachment.path}"),
        ),
      );
    }
  }

  Widget _buildActionArea(dynamic content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: MicRecorderButton(
            onRecordingComplete: (filePath) {
              debugPrint("Recorded file: $filePath");
            },
            onNext: () {
              debugPrint("Proceed to next step");
            },
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Add a note or message...",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: MemorySuccessPage(
            riveAssetPath: 'assets/animation/brain_animation.riv',
            onAnimationStateChanged: (callback) {
              // Store the callback so we can call it when DB operation completes
              _updateAnimationState = callback;
            },
            onAddedToMemory: () async {
              final String messageText = _controller.text;
              final imagePath = content.attachments[0].path;

              final userProvidedData = UserSharedTableCompanion.insert(
                contentType: "text",
                title: drift.Value("My First Title"),
                userMessage: drift.Value(messageText),
                audioPath: const drift.Value(null),
                imagePath: drift.Value(imagePath),
                isProcessed: const drift.Value(0),
                createdAt: drift.Value(DateTime.now().millisecondsSinceEpoch),
              );

              // Set loading state (2) before database operation
              _updateAnimationState?.call(2);

              context.read<LocalDataBaseContentBloc>().add(
                InsertUserContent(userProvidedData),
              );

              if (kDebugMode) {
                print("Attempting to add to DB");
              }
            },
          ),
        ),
      ],
    );
  }
}