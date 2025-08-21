import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_bloc.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_event.dart';

import '../../../core/domain/entities/shared_attachment.dart';
import '../../blocs/shared_content/shared_content_state.dart';

class SharedContentScreen extends StatefulWidget {
  const SharedContentScreen({super.key});

  @override
  State<SharedContentScreen> createState() => _SharedContentScreenState();
}

class _SharedContentScreenState extends State<SharedContentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SharedContentBloc>().add(SharedContentInitialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('Hmm , you want this in your second brain ?')
      ),
      body: BlocBuilder<SharedContentBloc,SharedContentState>(
        builder: (context,state) {
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
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Conversation ID: ${content.conversationIdentifier ?? 'None'}"),
          const SizedBox(height: 10),
          Text("Shared text: ${content.content ?? 'No text'}"),
          const SizedBox(height: 10),
          Text("Shared files: ${content.attachments.length}"),
          const SizedBox(height: 16),
          ...content.attachments.map((attachment) => _buildAttachmentWidget(attachment)),
        ],
      ),
    );
  }

  Widget _buildAttachmentWidget(dynamic attachment) {
    final path = attachment.path;
    if (path != null && attachment.type == SharedAttachmentType.image) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // context.read<SharedContentBloc>().add(
              //   // RecordSentMessage(
              //   //   conversationIdentifier: "custom-conversation-identifier",
              //   //   conversationName: "John Doe",
              //   //   conversationImageFilePath: path,
              //   //   serviceName: "custom-service-name",
              //   // ),
              // );
            },
            child: const Text("Record message"),
          ),
          const SizedBox(height: 10),
          Image.file(File(path)),
          const SizedBox(height: 16),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text("${attachment.type} Attachment: ${attachment.path}"),
      );
    }
  }
}
