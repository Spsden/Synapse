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
  String _selectedThinkMode = 'on_device'; // Default value

  @override
  void initState() {
    super.initState();
    context.read<SharedContentBloc>().add(SharedContentInitialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('Synapse: Capture')
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // // Conversation info
          // Text("Conversation ID: ${content.conversationIdentifier ?? 'None'}"),
          // const SizedBox(height: 8),
          // Text("Shared text: ${content.content ?? 'No text'}"),
          // const SizedBox(height: 8),

          // Files / images preview
          if (content.attachments.isNotEmpty)
            Expanded(
              child: ListView(
                children: content.attachments
                    .map<Widget>((attachment) => _buildAttachmentWidget(attachment))
                    .toList(),
              ),
            ),
          const SizedBox(height: 16),

          // Input + record button
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
        child: Image.file(File(path), fit: BoxFit.cover),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey[200],
          child: Text("${attachment.type} Attachment: ${attachment.path}"),
        ),
      );
    }
  }

  Widget _buildActionArea(dynamic content) {
    final TextEditingController _controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration:  InputDecoration(
              hintText: "Add a note or message...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // rounded corners
                borderSide: BorderSide.none, // no border
              ),
            ),
            onChanged: (text) {
              // context.read<SharedContentBloc>().add(
              //       AddAdditionalMessage(text),
              //     );
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.mic),
          onPressed: () {
            // TODO: Handle audio recording
          },
          tooltip: 'Record audio note',
        ),
        DropdownButton<String>(
          value: _selectedThinkMode,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedThinkMode = newValue;
              });
              print('Selected think mode: $newValue');
              // TODO: Dispatch event to BLoC to set think mode
            }
          },
          items: <String>['on_device', 'cloud']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value == 'on_device' ? 'On Device' : 'Cloud'),
            );
          }).toList(),
          icon: const Icon(Icons.psychology_alt),
          underline: Container(), // Hides the default underline
          // tooltip: 'Select Think Mode',
        ),
      ],
    );
  }


}
