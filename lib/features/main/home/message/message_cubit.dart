import 'dart:async';
import 'dart:io';
import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/network/supabase_service.dart';
import 'package:chatbox/core/utils/utils.dart';
import 'package:chatbox/data/models/entity/conversation_entity.dart';
import 'package:chatbox/data/models/entity/message/message_entity.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/models/enum/input_mode.dart';
import 'package:chatbox/data/models/enum/message_type.dart';
import 'package:chatbox/data/repository/conversation_repository.dart';
import 'package:chatbox/data/repository/media_repository.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:chatbox/features/main/home/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class MessageCubit extends Cubit<MessageState> {
  final ConversationRepository conversationRepos;
  StreamSubscription? _messageSubscription;
  String? _conversationId;

  final AppCubit appCubit;
  final UserEntity friend;
  final SupabaseService supabaseService = SupabaseService();
  final MediaRepository mediaRepos;
  final CallsCubit callCubit;

  MessageCubit({
    required this.conversationRepos,
    required this.friend,
    required this.appCubit,
    required this.mediaRepos,
    required this.callCubit,
  }) : super(MessageState());

  void init(String friendId) async {
    final resultConversationId = await conversationRepos.getConversationId(
      friendId,
    );
    resultConversationId.fold((failure) {}, (conversationId) {
      _conversationId = conversationId;
      subscribeMessage(conversationId);
    });
    await getMedias();
  }

  Future<File?> _getFile(AssetEntity entity) async {
    return await entity.file;
  }

  Future<void> _createConversation() async {
    if (friend.uid == null) return;
    final currentUser = appCubit.state.currentUser;
    if (currentUser == null) return;

    final conversation = ConversationEntity(
      memberIds: [friend.uid!, currentUser.uid!],
      lastMessageAt: DateTime.now(),
      lastSenderId: friend.uid,
      isGroup: false,
    );
    final result = await conversationRepos.createConversation(
      conversation: conversation,
      memberIds: conversation.memberIds ?? [],
    );
    result.fold(
      (failure) {
        return;
      },
      (conversationId) {
        _conversationId = conversationId;
        subscribeMessage(conversationId);
      },
    );
  }

  void subscribeMessage(String conversationId) {
    _messageSubscription?.cancel();
    _messageSubscription = conversationRepos.getMessages(conversationId).listen(
      (result) {
        result.fold(
          (failure) {},
          (messages) => emit(state.copyWith(messages: messages)),
        );
      },
    );
  }

  Future<void> onUploadFilesTap() async {
    final List<File> files = await pickFiles();
    if (files.isEmpty) return;

    for (final file in files) {
      final publicUrl = await supabaseService.uploadFileToSupabase(
        file: file,
        conversationId: _conversationId!,
        folder: 'documents',
      );
      sendMessage(file: file, type: MessageType.file, fileUrl: publicUrl);
    }
    emit(state.copyWith(files: files));
  }

  Future<void> onPressCamera() async {}

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }

  Future<void> sendMessage({
    String? text,
    required MessageType type,
    File? file,
    String? fileUrl,
  }) async {
    if (_conversationId == null || _conversationId!.isEmpty) {
      await _createConversation();
    }
    final message = MessageEntity(
      content: text,
      createdAt: DateTime.now(),
      type: type,
      fileName: file?.path.split('/').last,
      fileSize: file?.lengthSync().toString(),
      fileUrl: fileUrl,
      fileType: file?.path.split('.').last,
      senderId: appCubit.state.currentUser?.uid,
    );

    conversationRepos.sendMessage(
      conversationId: _conversationId!,
      message: message,
    );

    final conversation = ConversationEntity(
      id: _conversationId,
      lastMessage: type.lastMessage(text),
      lastMessageAt: DateTime.now(),
      lastSenderId: appCubit.state.currentUser?.uid,
    );
    conversationRepos.updateConversation(conversation);
  }

  Future<void> uploadSelectedMedias() async {
    for (final media in state.selectedMedias) {
      final file = await _getFile(media);
      if (file == null) continue;

      final publicUrl = await supabaseService.uploadFileToSupabase(
        file: file,
        conversationId: _conversationId!,
        folder: 'images',
      );
      sendMessage(type: MessageType.image, file: file, fileUrl: publicUrl);
    }

    emit(state.copyWith(selectedMedias: []));
  }

  void showMedia() {
    emit(state.copyWith(inputMode: InputMode.media));
  }

  void showKeyboard() {
    emit(state.copyWith(inputMode: InputMode.keyboard));
  }

  void hideInput() {
    emit(state.copyWith(inputMode: InputMode.none));
  }

  // medias
  Future<void> getMedias() async {
    final medias = await mediaRepos.getRecentMedias();
    emit(state.copyWith(medias: medias));
  }

  void toggleSelect(AssetEntity? media) {
    if (media == null) return;
    final selected = List<AssetEntity>.from(state.selectedMedias);
    if (selected.contains(media)) {
      selected.remove(media);
    } else {
      selected.add(media);
    }
    emit(state.copyWith(selectedMedias: selected));
    if (selected.isEmpty) {
      emit(state.copyWith(inputMode: InputMode.keyboard));
    }
  }

  bool isSelected(AssetEntity media) {
    return state.selectedMedias.any((e) => e.id == media.id);
  }

  bool hasSelected() {
    return state.selectedMedias.isNotEmpty;
  }

  void onPressCall(UserEntity receiver, {bool isVideo = false}) {
    callCubit.startCall(receiver: receiver, isVideo: isVideo);
  }
}
