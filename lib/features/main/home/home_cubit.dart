import 'dart:async';
import 'package:chatbox/data/models/conversation/conversation_entity.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/repository/conversation_repository.dart';
import 'package:chatbox/data/repository/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_navigator.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FriendRepository friendRepository;
  final HomeNavigator navigator;
  final ConversationRepository conversationRepos;
  StreamSubscription? _streamChattedConversation;

  HomeCubit({
    required this.navigator,
    required this.friendRepository,
    required this.conversationRepos,
  }) : super(HomeState());

  void fetchData() async {
    final friends = await friendRepository.getOnlineFriends();
    emit(state.copyWith(onlineFriends: friends));
    getChattedConversations();
  }

  void getChattedConversations() {
    _streamChattedConversation?.cancel();
    _streamChattedConversation = conversationRepos
        .getChattedConversations(state.onlineFriends)
        .listen((result) {
          result.fold(
            (failure) {
              return;
            },
            (friends) {
              emit(state.copyWith(chats: friends));
            },
          );
        });
  }

  void onPressItemChat(ConversationEntity conversation, UserEntity friend) {
    navigator.openMessagePage(friend);
  }

  void onPressSearch() {
    navigator.openSearchPage();
  }

  void onPressAvt(UserEntity user) {
    navigator.openProfilePage(user);
  }
}
