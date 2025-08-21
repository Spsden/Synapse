import 'package:equatable/equatable.dart';

enum SharedAttachmentType { image, video, file, text, unknown }

class SharedAttachment extends Equatable {
  final String? path;
  final SharedAttachmentType type;
  final String? mimeType;
  final int? size;

  const SharedAttachment({
    this.path,
    required this.type,
    this.mimeType,
    this.size,
  });

  @override
  List<Object?> get props => [path, type, mimeType, size];

}
