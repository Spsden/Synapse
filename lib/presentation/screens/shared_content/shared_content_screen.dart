import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_bloc.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_event.dart';

import '../../../core/domain/entities/shared_attachment.dart';
import '../../blocs/shared_content/shared_content_state.dart';
import '../../widgets/mic_recorder_button.dart';

class SharedContentScreen extends StatefulWidget {
  const SharedContentScreen({super.key});

  @override
  State<SharedContentScreen> createState() => _SharedContentScreenState();
}

class _SharedContentScreenState extends State<SharedContentScreen> {
  String _selectedThinkMode = 'on_device'; // Default value
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SharedContentBloc>().add(SharedContentInitialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Synapse: Capture',
          style: TextStyle(
            fontSize: 18, // Reduced title size
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SharedContentBloc, SharedContentState>(
        builder: (context, state) {
          return _buildBody(state);
        },
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
          borderRadius: BorderRadius.circular(16), // Circular image preview
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
            borderRadius: BorderRadius.circular(12), // Rounded file box
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
        // MIC BUTTON ON LEFT
        Container(
          margin: const EdgeInsets.only(right: 12), // Equal spacing
          child:
          MicRecorderButton(
            onRecordingComplete: (filePath) {
              // Handle recorded file path here
              debugPrint("Recorded file: $filePath");
            },
            onNext: () {
              debugPrint("Proceed to next step");
            },
          ),

          // GestureDetector(
          //   onTap: () {
          //     // TODO: Handle audio recording
          //   },
          //   child: Container(
          //     width: 48, // Fixed size to match next button visually
          //     height: 48,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       gradient: LinearGradient(
          //         colors: [Color(0xFF2A2C3A), Color(0xFF3B3D5A)],
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //       ),
          //     ),
          //     child: const Icon(Icons.mic, color: Colors.white, size: 22),
          //   ),
          // ),
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
          child: ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(14),
              backgroundColor: Colors.blueAccent,
              elevation: 4,
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
