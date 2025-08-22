// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserSharedTableTable extends UserSharedTable
    with TableInfo<$UserSharedTableTable, UserSharedTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSharedTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userMessageMeta = const VerificationMeta(
    'userMessage',
  );
  @override
  late final GeneratedColumn<String> userMessage = GeneratedColumn<String>(
    'user_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isProcessedMeta = const VerificationMeta(
    'isProcessed',
  );
  @override
  late final GeneratedColumn<int> isProcessed = GeneratedColumn<int>(
    'is_processed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().millisecondsSinceEpoch,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentType,
    title,
    userMessage,
    audioPath,
    imagePath,
    isProcessed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_shared_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSharedTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('user_message')) {
      context.handle(
        _userMessageMeta,
        userMessage.isAcceptableOrUnknown(
          data['user_message']!,
          _userMessageMeta,
        ),
      );
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('is_processed')) {
      context.handle(
        _isProcessedMeta,
        isProcessed.isAcceptableOrUnknown(
          data['is_processed']!,
          _isProcessedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSharedTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSharedTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      userMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_message'],
      ),
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      isProcessed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_processed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserSharedTableTable createAlias(String alias) {
    return $UserSharedTableTable(attachedDatabase, alias);
  }
}

class UserSharedTableData extends DataClass
    implements Insertable<UserSharedTableData> {
  final int id;
  final String contentType;
  final String? title;
  final String? userMessage;
  final String? audioPath;
  final String? imagePath;
  final int isProcessed;
  final int createdAt;
  const UserSharedTableData({
    required this.id,
    required this.contentType,
    this.title,
    this.userMessage,
    this.audioPath,
    this.imagePath,
    required this.isProcessed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_type'] = Variable<String>(contentType);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || userMessage != null) {
      map['user_message'] = Variable<String>(userMessage);
    }
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['is_processed'] = Variable<int>(isProcessed);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  UserSharedTableCompanion toCompanion(bool nullToAbsent) {
    return UserSharedTableCompanion(
      id: Value(id),
      contentType: Value(contentType),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      userMessage: userMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(userMessage),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      isProcessed: Value(isProcessed),
      createdAt: Value(createdAt),
    );
  }

  factory UserSharedTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSharedTableData(
      id: serializer.fromJson<int>(json['id']),
      contentType: serializer.fromJson<String>(json['contentType']),
      title: serializer.fromJson<String?>(json['title']),
      userMessage: serializer.fromJson<String?>(json['userMessage']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      isProcessed: serializer.fromJson<int>(json['isProcessed']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentType': serializer.toJson<String>(contentType),
      'title': serializer.toJson<String?>(title),
      'userMessage': serializer.toJson<String?>(userMessage),
      'audioPath': serializer.toJson<String?>(audioPath),
      'imagePath': serializer.toJson<String?>(imagePath),
      'isProcessed': serializer.toJson<int>(isProcessed),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  UserSharedTableData copyWith({
    int? id,
    String? contentType,
    Value<String?> title = const Value.absent(),
    Value<String?> userMessage = const Value.absent(),
    Value<String?> audioPath = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    int? isProcessed,
    int? createdAt,
  }) => UserSharedTableData(
    id: id ?? this.id,
    contentType: contentType ?? this.contentType,
    title: title.present ? title.value : this.title,
    userMessage: userMessage.present ? userMessage.value : this.userMessage,
    audioPath: audioPath.present ? audioPath.value : this.audioPath,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    isProcessed: isProcessed ?? this.isProcessed,
    createdAt: createdAt ?? this.createdAt,
  );
  UserSharedTableData copyWithCompanion(UserSharedTableCompanion data) {
    return UserSharedTableData(
      id: data.id.present ? data.id.value : this.id,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      title: data.title.present ? data.title.value : this.title,
      userMessage: data.userMessage.present
          ? data.userMessage.value
          : this.userMessage,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isProcessed: data.isProcessed.present
          ? data.isProcessed.value
          : this.isProcessed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSharedTableData(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('title: $title, ')
          ..write('userMessage: $userMessage, ')
          ..write('audioPath: $audioPath, ')
          ..write('imagePath: $imagePath, ')
          ..write('isProcessed: $isProcessed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentType,
    title,
    userMessage,
    audioPath,
    imagePath,
    isProcessed,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSharedTableData &&
          other.id == this.id &&
          other.contentType == this.contentType &&
          other.title == this.title &&
          other.userMessage == this.userMessage &&
          other.audioPath == this.audioPath &&
          other.imagePath == this.imagePath &&
          other.isProcessed == this.isProcessed &&
          other.createdAt == this.createdAt);
}

class UserSharedTableCompanion extends UpdateCompanion<UserSharedTableData> {
  final Value<int> id;
  final Value<String> contentType;
  final Value<String?> title;
  final Value<String?> userMessage;
  final Value<String?> audioPath;
  final Value<String?> imagePath;
  final Value<int> isProcessed;
  final Value<int> createdAt;
  const UserSharedTableCompanion({
    this.id = const Value.absent(),
    this.contentType = const Value.absent(),
    this.title = const Value.absent(),
    this.userMessage = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isProcessed = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserSharedTableCompanion.insert({
    this.id = const Value.absent(),
    required String contentType,
    this.title = const Value.absent(),
    this.userMessage = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isProcessed = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : contentType = Value(contentType);
  static Insertable<UserSharedTableData> custom({
    Expression<int>? id,
    Expression<String>? contentType,
    Expression<String>? title,
    Expression<String>? userMessage,
    Expression<String>? audioPath,
    Expression<String>? imagePath,
    Expression<int>? isProcessed,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentType != null) 'content_type': contentType,
      if (title != null) 'title': title,
      if (userMessage != null) 'user_message': userMessage,
      if (audioPath != null) 'audio_path': audioPath,
      if (imagePath != null) 'image_path': imagePath,
      if (isProcessed != null) 'is_processed': isProcessed,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserSharedTableCompanion copyWith({
    Value<int>? id,
    Value<String>? contentType,
    Value<String?>? title,
    Value<String?>? userMessage,
    Value<String?>? audioPath,
    Value<String?>? imagePath,
    Value<int>? isProcessed,
    Value<int>? createdAt,
  }) {
    return UserSharedTableCompanion(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      title: title ?? this.title,
      userMessage: userMessage ?? this.userMessage,
      audioPath: audioPath ?? this.audioPath,
      imagePath: imagePath ?? this.imagePath,
      isProcessed: isProcessed ?? this.isProcessed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (userMessage.present) {
      map['user_message'] = Variable<String>(userMessage.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isProcessed.present) {
      map['is_processed'] = Variable<int>(isProcessed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSharedTableCompanion(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('title: $title, ')
          ..write('userMessage: $userMessage, ')
          ..write('audioPath: $audioPath, ')
          ..write('imagePath: $imagePath, ')
          ..write('isProcessed: $isProcessed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ContentAnalysesTable extends ContentAnalyses
    with TableInfo<$ContentAnalysesTable, ContentAnalyse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentAnalysesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<int> contentId = GeneratedColumn<int>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_shared_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _llmTypeMeta = const VerificationMeta(
    'llmType',
  );
  @override
  late final GeneratedColumn<String> llmType = GeneratedColumn<String>(
    'llm_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _analysisTypeMeta = const VerificationMeta(
    'analysisType',
  );
  @override
  late final GeneratedColumn<String> analysisType = GeneratedColumn<String>(
    'analysis_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
    'prompt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().millisecondsSinceEpoch,
  );
  static const VerificationMeta _processingTimeMsMeta = const VerificationMeta(
    'processingTimeMs',
  );
  @override
  late final GeneratedColumn<int> processingTimeMs = GeneratedColumn<int>(
    'processing_time_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentId,
    llmType,
    analysisType,
    prompt,
    result,
    metadata,
    createdAt,
    processingTimeMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_analyses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentAnalyse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('llm_type')) {
      context.handle(
        _llmTypeMeta,
        llmType.isAcceptableOrUnknown(data['llm_type']!, _llmTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_llmTypeMeta);
    }
    if (data.containsKey('analysis_type')) {
      context.handle(
        _analysisTypeMeta,
        analysisType.isAcceptableOrUnknown(
          data['analysis_type']!,
          _analysisTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_analysisTypeMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(
        _promptMeta,
        prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('processing_time_ms')) {
      context.handle(
        _processingTimeMsMeta,
        processingTimeMs.isAcceptableOrUnknown(
          data['processing_time_ms']!,
          _processingTimeMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentAnalyse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentAnalyse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_id'],
      )!,
      llmType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}llm_type'],
      )!,
      analysisType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}analysis_type'],
      )!,
      prompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt'],
      ),
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      processingTimeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}processing_time_ms'],
      ),
    );
  }

  @override
  $ContentAnalysesTable createAlias(String alias) {
    return $ContentAnalysesTable(attachedDatabase, alias);
  }
}

class ContentAnalyse extends DataClass implements Insertable<ContentAnalyse> {
  final int id;
  final int contentId;
  final String llmType;
  final String analysisType;
  final String? prompt;
  final String? result;
  final String? metadata;
  final int createdAt;
  final int? processingTimeMs;
  const ContentAnalyse({
    required this.id,
    required this.contentId,
    required this.llmType,
    required this.analysisType,
    this.prompt,
    this.result,
    this.metadata,
    required this.createdAt,
    this.processingTimeMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_id'] = Variable<int>(contentId);
    map['llm_type'] = Variable<String>(llmType);
    map['analysis_type'] = Variable<String>(analysisType);
    if (!nullToAbsent || prompt != null) {
      map['prompt'] = Variable<String>(prompt);
    }
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || processingTimeMs != null) {
      map['processing_time_ms'] = Variable<int>(processingTimeMs);
    }
    return map;
  }

  ContentAnalysesCompanion toCompanion(bool nullToAbsent) {
    return ContentAnalysesCompanion(
      id: Value(id),
      contentId: Value(contentId),
      llmType: Value(llmType),
      analysisType: Value(analysisType),
      prompt: prompt == null && nullToAbsent
          ? const Value.absent()
          : Value(prompt),
      result: result == null && nullToAbsent
          ? const Value.absent()
          : Value(result),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      createdAt: Value(createdAt),
      processingTimeMs: processingTimeMs == null && nullToAbsent
          ? const Value.absent()
          : Value(processingTimeMs),
    );
  }

  factory ContentAnalyse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentAnalyse(
      id: serializer.fromJson<int>(json['id']),
      contentId: serializer.fromJson<int>(json['contentId']),
      llmType: serializer.fromJson<String>(json['llmType']),
      analysisType: serializer.fromJson<String>(json['analysisType']),
      prompt: serializer.fromJson<String?>(json['prompt']),
      result: serializer.fromJson<String?>(json['result']),
      metadata: serializer.fromJson<String?>(json['metadata']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      processingTimeMs: serializer.fromJson<int?>(json['processingTimeMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentId': serializer.toJson<int>(contentId),
      'llmType': serializer.toJson<String>(llmType),
      'analysisType': serializer.toJson<String>(analysisType),
      'prompt': serializer.toJson<String?>(prompt),
      'result': serializer.toJson<String?>(result),
      'metadata': serializer.toJson<String?>(metadata),
      'createdAt': serializer.toJson<int>(createdAt),
      'processingTimeMs': serializer.toJson<int?>(processingTimeMs),
    };
  }

  ContentAnalyse copyWith({
    int? id,
    int? contentId,
    String? llmType,
    String? analysisType,
    Value<String?> prompt = const Value.absent(),
    Value<String?> result = const Value.absent(),
    Value<String?> metadata = const Value.absent(),
    int? createdAt,
    Value<int?> processingTimeMs = const Value.absent(),
  }) => ContentAnalyse(
    id: id ?? this.id,
    contentId: contentId ?? this.contentId,
    llmType: llmType ?? this.llmType,
    analysisType: analysisType ?? this.analysisType,
    prompt: prompt.present ? prompt.value : this.prompt,
    result: result.present ? result.value : this.result,
    metadata: metadata.present ? metadata.value : this.metadata,
    createdAt: createdAt ?? this.createdAt,
    processingTimeMs: processingTimeMs.present
        ? processingTimeMs.value
        : this.processingTimeMs,
  );
  ContentAnalyse copyWithCompanion(ContentAnalysesCompanion data) {
    return ContentAnalyse(
      id: data.id.present ? data.id.value : this.id,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      llmType: data.llmType.present ? data.llmType.value : this.llmType,
      analysisType: data.analysisType.present
          ? data.analysisType.value
          : this.analysisType,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      result: data.result.present ? data.result.value : this.result,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      processingTimeMs: data.processingTimeMs.present
          ? data.processingTimeMs.value
          : this.processingTimeMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentAnalyse(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('llmType: $llmType, ')
          ..write('analysisType: $analysisType, ')
          ..write('prompt: $prompt, ')
          ..write('result: $result, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('processingTimeMs: $processingTimeMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentId,
    llmType,
    analysisType,
    prompt,
    result,
    metadata,
    createdAt,
    processingTimeMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentAnalyse &&
          other.id == this.id &&
          other.contentId == this.contentId &&
          other.llmType == this.llmType &&
          other.analysisType == this.analysisType &&
          other.prompt == this.prompt &&
          other.result == this.result &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt &&
          other.processingTimeMs == this.processingTimeMs);
}

class ContentAnalysesCompanion extends UpdateCompanion<ContentAnalyse> {
  final Value<int> id;
  final Value<int> contentId;
  final Value<String> llmType;
  final Value<String> analysisType;
  final Value<String?> prompt;
  final Value<String?> result;
  final Value<String?> metadata;
  final Value<int> createdAt;
  final Value<int?> processingTimeMs;
  const ContentAnalysesCompanion({
    this.id = const Value.absent(),
    this.contentId = const Value.absent(),
    this.llmType = const Value.absent(),
    this.analysisType = const Value.absent(),
    this.prompt = const Value.absent(),
    this.result = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.processingTimeMs = const Value.absent(),
  });
  ContentAnalysesCompanion.insert({
    this.id = const Value.absent(),
    required int contentId,
    required String llmType,
    required String analysisType,
    this.prompt = const Value.absent(),
    this.result = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.processingTimeMs = const Value.absent(),
  }) : contentId = Value(contentId),
       llmType = Value(llmType),
       analysisType = Value(analysisType);
  static Insertable<ContentAnalyse> custom({
    Expression<int>? id,
    Expression<int>? contentId,
    Expression<String>? llmType,
    Expression<String>? analysisType,
    Expression<String>? prompt,
    Expression<String>? result,
    Expression<String>? metadata,
    Expression<int>? createdAt,
    Expression<int>? processingTimeMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentId != null) 'content_id': contentId,
      if (llmType != null) 'llm_type': llmType,
      if (analysisType != null) 'analysis_type': analysisType,
      if (prompt != null) 'prompt': prompt,
      if (result != null) 'result': result,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (processingTimeMs != null) 'processing_time_ms': processingTimeMs,
    });
  }

  ContentAnalysesCompanion copyWith({
    Value<int>? id,
    Value<int>? contentId,
    Value<String>? llmType,
    Value<String>? analysisType,
    Value<String?>? prompt,
    Value<String?>? result,
    Value<String?>? metadata,
    Value<int>? createdAt,
    Value<int?>? processingTimeMs,
  }) {
    return ContentAnalysesCompanion(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      llmType: llmType ?? this.llmType,
      analysisType: analysisType ?? this.analysisType,
      prompt: prompt ?? this.prompt,
      result: result ?? this.result,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<int>(contentId.value);
    }
    if (llmType.present) {
      map['llm_type'] = Variable<String>(llmType.value);
    }
    if (analysisType.present) {
      map['analysis_type'] = Variable<String>(analysisType.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (processingTimeMs.present) {
      map['processing_time_ms'] = Variable<int>(processingTimeMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentAnalysesCompanion(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('llmType: $llmType, ')
          ..write('analysisType: $analysisType, ')
          ..write('prompt: $prompt, ')
          ..write('result: $result, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('processingTimeMs: $processingTimeMs')
          ..write(')'))
        .toString();
  }
}

abstract class _$SynapseAppDataBase extends GeneratedDatabase {
  _$SynapseAppDataBase(QueryExecutor e) : super(e);
  $SynapseAppDataBaseManager get managers => $SynapseAppDataBaseManager(this);
  late final $UserSharedTableTable userSharedTable = $UserSharedTableTable(
    this,
  );
  late final $ContentAnalysesTable contentAnalyses = $ContentAnalysesTable(
    this,
  );
  late final SynapseLocalDao synapseLocalDao = SynapseLocalDao(
    this as SynapseAppDataBase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userSharedTable,
    contentAnalyses,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_shared_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('content_analyses', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UserSharedTableTableCreateCompanionBuilder =
    UserSharedTableCompanion Function({
      Value<int> id,
      required String contentType,
      Value<String?> title,
      Value<String?> userMessage,
      Value<String?> audioPath,
      Value<String?> imagePath,
      Value<int> isProcessed,
      Value<int> createdAt,
    });
typedef $$UserSharedTableTableUpdateCompanionBuilder =
    UserSharedTableCompanion Function({
      Value<int> id,
      Value<String> contentType,
      Value<String?> title,
      Value<String?> userMessage,
      Value<String?> audioPath,
      Value<String?> imagePath,
      Value<int> isProcessed,
      Value<int> createdAt,
    });

final class $$UserSharedTableTableReferences
    extends
        BaseReferences<
          _$SynapseAppDataBase,
          $UserSharedTableTable,
          UserSharedTableData
        > {
  $$UserSharedTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ContentAnalysesTable, List<ContentAnalyse>>
  _contentAnalysesRefsTable(_$SynapseAppDataBase db) =>
      MultiTypedResultKey.fromTable(
        db.contentAnalyses,
        aliasName: $_aliasNameGenerator(
          db.userSharedTable.id,
          db.contentAnalyses.contentId,
        ),
      );

  $$ContentAnalysesTableProcessedTableManager get contentAnalysesRefs {
    final manager = $$ContentAnalysesTableTableManager(
      $_db,
      $_db.contentAnalyses,
    ).filter((f) => f.contentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _contentAnalysesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserSharedTableTableFilterComposer
    extends Composer<_$SynapseAppDataBase, $UserSharedTableTable> {
  $$UserSharedTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userMessage => $composableBuilder(
    column: $table.userMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> contentAnalysesRefs(
    Expression<bool> Function($$ContentAnalysesTableFilterComposer f) f,
  ) {
    final $$ContentAnalysesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contentAnalyses,
      getReferencedColumn: (t) => t.contentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentAnalysesTableFilterComposer(
            $db: $db,
            $table: $db.contentAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserSharedTableTableOrderingComposer
    extends Composer<_$SynapseAppDataBase, $UserSharedTableTable> {
  $$UserSharedTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userMessage => $composableBuilder(
    column: $table.userMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSharedTableTableAnnotationComposer
    extends Composer<_$SynapseAppDataBase, $UserSharedTableTable> {
  $$UserSharedTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get userMessage => $composableBuilder(
    column: $table.userMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> contentAnalysesRefs<T extends Object>(
    Expression<T> Function($$ContentAnalysesTableAnnotationComposer a) f,
  ) {
    final $$ContentAnalysesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contentAnalyses,
      getReferencedColumn: (t) => t.contentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentAnalysesTableAnnotationComposer(
            $db: $db,
            $table: $db.contentAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserSharedTableTableTableManager
    extends
        RootTableManager<
          _$SynapseAppDataBase,
          $UserSharedTableTable,
          UserSharedTableData,
          $$UserSharedTableTableFilterComposer,
          $$UserSharedTableTableOrderingComposer,
          $$UserSharedTableTableAnnotationComposer,
          $$UserSharedTableTableCreateCompanionBuilder,
          $$UserSharedTableTableUpdateCompanionBuilder,
          (UserSharedTableData, $$UserSharedTableTableReferences),
          UserSharedTableData,
          PrefetchHooks Function({bool contentAnalysesRefs})
        > {
  $$UserSharedTableTableTableManager(
    _$SynapseAppDataBase db,
    $UserSharedTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSharedTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSharedTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSharedTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> userMessage = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> isProcessed = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => UserSharedTableCompanion(
                id: id,
                contentType: contentType,
                title: title,
                userMessage: userMessage,
                audioPath: audioPath,
                imagePath: imagePath,
                isProcessed: isProcessed,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentType,
                Value<String?> title = const Value.absent(),
                Value<String?> userMessage = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> isProcessed = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => UserSharedTableCompanion.insert(
                id: id,
                contentType: contentType,
                title: title,
                userMessage: userMessage,
                audioPath: audioPath,
                imagePath: imagePath,
                isProcessed: isProcessed,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserSharedTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({contentAnalysesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (contentAnalysesRefs) db.contentAnalyses,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (contentAnalysesRefs)
                    await $_getPrefetchedData<
                      UserSharedTableData,
                      $UserSharedTableTable,
                      ContentAnalyse
                    >(
                      currentTable: table,
                      referencedTable: $$UserSharedTableTableReferences
                          ._contentAnalysesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UserSharedTableTableReferences(
                            db,
                            table,
                            p0,
                          ).contentAnalysesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.contentId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UserSharedTableTableProcessedTableManager =
    ProcessedTableManager<
      _$SynapseAppDataBase,
      $UserSharedTableTable,
      UserSharedTableData,
      $$UserSharedTableTableFilterComposer,
      $$UserSharedTableTableOrderingComposer,
      $$UserSharedTableTableAnnotationComposer,
      $$UserSharedTableTableCreateCompanionBuilder,
      $$UserSharedTableTableUpdateCompanionBuilder,
      (UserSharedTableData, $$UserSharedTableTableReferences),
      UserSharedTableData,
      PrefetchHooks Function({bool contentAnalysesRefs})
    >;
typedef $$ContentAnalysesTableCreateCompanionBuilder =
    ContentAnalysesCompanion Function({
      Value<int> id,
      required int contentId,
      required String llmType,
      required String analysisType,
      Value<String?> prompt,
      Value<String?> result,
      Value<String?> metadata,
      Value<int> createdAt,
      Value<int?> processingTimeMs,
    });
typedef $$ContentAnalysesTableUpdateCompanionBuilder =
    ContentAnalysesCompanion Function({
      Value<int> id,
      Value<int> contentId,
      Value<String> llmType,
      Value<String> analysisType,
      Value<String?> prompt,
      Value<String?> result,
      Value<String?> metadata,
      Value<int> createdAt,
      Value<int?> processingTimeMs,
    });

final class $$ContentAnalysesTableReferences
    extends
        BaseReferences<
          _$SynapseAppDataBase,
          $ContentAnalysesTable,
          ContentAnalyse
        > {
  $$ContentAnalysesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserSharedTableTable _contentIdTable(_$SynapseAppDataBase db) =>
      db.userSharedTable.createAlias(
        $_aliasNameGenerator(
          db.contentAnalyses.contentId,
          db.userSharedTable.id,
        ),
      );

  $$UserSharedTableTableProcessedTableManager get contentId {
    final $_column = $_itemColumn<int>('content_id')!;

    final manager = $$UserSharedTableTableTableManager(
      $_db,
      $_db.userSharedTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContentAnalysesTableFilterComposer
    extends Composer<_$SynapseAppDataBase, $ContentAnalysesTable> {
  $$ContentAnalysesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get llmType => $composableBuilder(
    column: $table.llmType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get analysisType => $composableBuilder(
    column: $table.analysisType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get processingTimeMs => $composableBuilder(
    column: $table.processingTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  $$UserSharedTableTableFilterComposer get contentId {
    final $$UserSharedTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.userSharedTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserSharedTableTableFilterComposer(
            $db: $db,
            $table: $db.userSharedTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentAnalysesTableOrderingComposer
    extends Composer<_$SynapseAppDataBase, $ContentAnalysesTable> {
  $$ContentAnalysesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get llmType => $composableBuilder(
    column: $table.llmType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get analysisType => $composableBuilder(
    column: $table.analysisType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get processingTimeMs => $composableBuilder(
    column: $table.processingTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserSharedTableTableOrderingComposer get contentId {
    final $$UserSharedTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.userSharedTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserSharedTableTableOrderingComposer(
            $db: $db,
            $table: $db.userSharedTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentAnalysesTableAnnotationComposer
    extends Composer<_$SynapseAppDataBase, $ContentAnalysesTable> {
  $$ContentAnalysesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get llmType =>
      $composableBuilder(column: $table.llmType, builder: (column) => column);

  GeneratedColumn<String> get analysisType => $composableBuilder(
    column: $table.analysisType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get processingTimeMs => $composableBuilder(
    column: $table.processingTimeMs,
    builder: (column) => column,
  );

  $$UserSharedTableTableAnnotationComposer get contentId {
    final $$UserSharedTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.userSharedTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserSharedTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userSharedTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentAnalysesTableTableManager
    extends
        RootTableManager<
          _$SynapseAppDataBase,
          $ContentAnalysesTable,
          ContentAnalyse,
          $$ContentAnalysesTableFilterComposer,
          $$ContentAnalysesTableOrderingComposer,
          $$ContentAnalysesTableAnnotationComposer,
          $$ContentAnalysesTableCreateCompanionBuilder,
          $$ContentAnalysesTableUpdateCompanionBuilder,
          (ContentAnalyse, $$ContentAnalysesTableReferences),
          ContentAnalyse,
          PrefetchHooks Function({bool contentId})
        > {
  $$ContentAnalysesTableTableManager(
    _$SynapseAppDataBase db,
    $ContentAnalysesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentAnalysesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentAnalysesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentAnalysesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> contentId = const Value.absent(),
                Value<String> llmType = const Value.absent(),
                Value<String> analysisType = const Value.absent(),
                Value<String?> prompt = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> processingTimeMs = const Value.absent(),
              }) => ContentAnalysesCompanion(
                id: id,
                contentId: contentId,
                llmType: llmType,
                analysisType: analysisType,
                prompt: prompt,
                result: result,
                metadata: metadata,
                createdAt: createdAt,
                processingTimeMs: processingTimeMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int contentId,
                required String llmType,
                required String analysisType,
                Value<String?> prompt = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> processingTimeMs = const Value.absent(),
              }) => ContentAnalysesCompanion.insert(
                id: id,
                contentId: contentId,
                llmType: llmType,
                analysisType: analysisType,
                prompt: prompt,
                result: result,
                metadata: metadata,
                createdAt: createdAt,
                processingTimeMs: processingTimeMs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContentAnalysesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({contentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (contentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.contentId,
                                referencedTable:
                                    $$ContentAnalysesTableReferences
                                        ._contentIdTable(db),
                                referencedColumn:
                                    $$ContentAnalysesTableReferences
                                        ._contentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContentAnalysesTableProcessedTableManager =
    ProcessedTableManager<
      _$SynapseAppDataBase,
      $ContentAnalysesTable,
      ContentAnalyse,
      $$ContentAnalysesTableFilterComposer,
      $$ContentAnalysesTableOrderingComposer,
      $$ContentAnalysesTableAnnotationComposer,
      $$ContentAnalysesTableCreateCompanionBuilder,
      $$ContentAnalysesTableUpdateCompanionBuilder,
      (ContentAnalyse, $$ContentAnalysesTableReferences),
      ContentAnalyse,
      PrefetchHooks Function({bool contentId})
    >;

class $SynapseAppDataBaseManager {
  final _$SynapseAppDataBase _db;
  $SynapseAppDataBaseManager(this._db);
  $$UserSharedTableTableTableManager get userSharedTable =>
      $$UserSharedTableTableTableManager(_db, _db.userSharedTable);
  $$ContentAnalysesTableTableManager get contentAnalyses =>
      $$ContentAnalysesTableTableManager(_db, _db.contentAnalyses);
}
