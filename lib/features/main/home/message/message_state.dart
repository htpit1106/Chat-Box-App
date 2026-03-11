import 'dart:io';

import 'package:chatbox/data/models/entity/message/message_entity.dart';
import 'package:chatbox/data/models/enum/input_mode.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

class MessageState extends Equatable {
  final List<MessageEntity> messages;
  final InputMode inputMode;
  final List<File> files;
  final List<AssetEntity> selectedMedias;
  final List<AssetEntity> medias;
  const MessageState({
    this.messages = const [],
    this.files = const [],
    this.inputMode = InputMode.keyboard,
    this.selectedMedias = const [],
    this.medias = const [],
  });

  MessageState copyWith({
    List<MessageEntity>? messages,
    List<File>? files,
    InputMode? inputMode,
    List<AssetEntity>? selectedMedias,
    List<AssetEntity>? medias,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      files: files ?? this.files,
      inputMode: inputMode ?? this.inputMode,
      selectedMedias: selectedMedias ?? this.selectedMedias,
      medias: medias ?? this.medias,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    files,
    inputMode,
    selectedMedias,
    medias,
  ];
}
