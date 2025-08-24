import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/data_sources/local/database/database.dart';

class ScreenshotCard extends StatelessWidget {
  final UserSharedTableData content;

  const ScreenshotCard({super.key, required this.content});

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(date);
    }
  }

  DateTime? _getCreatedAt() {
    return DateTime.fromMillisecondsSinceEpoch(content.createdAt * 1000);
  }

  Widget _buildImage(BuildContext context) {
    final imagePath = content.imagePath;

    if (imagePath == null || imagePath.isEmpty) {
      return _buildErrorPlaceholder(context);
    }
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      // Network image
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorPlaceholder(context),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder(loadingProgress, context);
        },
      );
    } else {
      // Local file image
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorPlaceholder(context),
      );
    }
  }

  Widget _buildErrorPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getContentTypeIcon(),
            size: 32,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            _getContentTypeLabel(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingPlaceholder(
    ImageChunkEvent loadingProgress,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: content != null
          ? () {
              // Navigate to content detail view or show a dialog
              _showContentDetails(context);
            }
          : null,
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      _buildImage(context),
                      // Content type badge
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surface.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getContentTypeIcon(),
                                size: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _getContentTypeLabel(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Processing status indicator
                      if (content.isProcessed == 0)
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Processing',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Content info section
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content.title ?? "LOL",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      ...[
                        Text(
                          _formatDate(_getCreatedAt()),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                      if (content.userMessage != null &&
                          content.userMessage!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          content.userMessage!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContentDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(content.title ?? 'Content Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (content.userMessage != null) ...[
                Text('Message:', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(content.userMessage!),
                const SizedBox(height: 12),
              ],
              Text('Type:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(content.contentType ?? 'Unknown'),
              const SizedBox(height: 12),
              Text('Created:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(_formatDate(_getCreatedAt())),
              const SizedBox(height: 12),
              Text('Status:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(content.isProcessed == 1 ? 'Processed' : 'Pending'),
              if (content.audioPath != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Has Audio:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text('Yes'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  IconData _getContentTypeIcon() {
    if (content == null) return Icons.image;

    // Use the contentType from UserSharedTableData
    final contentType = content.contentType.toLowerCase();

    switch (contentType) {
      case 'image':
      case 'screenshot':
        return Icons.image;
      case 'video':
        return Icons.videocam;
      case 'audio':
        return Icons.audio_file;
      case 'document':
      case 'text':
        return Icons.description;
      case 'url':
      case 'link':
        return Icons.link;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _getContentTypeLabel() {
    final contentType = content.contentType.toLowerCase();

    switch (contentType) {
      case 'image':
      case 'screenshot':
        return 'Image';
      case 'video':
        return 'Video';
      case 'audio':
        return 'Audio';
      case 'document':
      case 'text':
        return 'Doc';
      case 'url':
      case 'link':
        return 'Link';
      default:
        return 'File';
    }
  }
}
