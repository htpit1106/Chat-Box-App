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

  HomeCubit({
    required this.navigator,
    required this.friendRepository,
    required this.conversationRepos,
  }) : super(HomeState());

  void fetchData() async {
    final friends = await friendRepository.getOnlineFriends();
    emit(state.copyWith(onlineFriends: friends));
    final chats = await conversationRepos.getChattedConversations(friends);
    emit(state.copyWith(chats: chats));
  }

  void onPressItemChat(ConversationEntity conversation, UserEntity friend) {
    // conversationRepos.createConversation(
    //   conversation: conversation,
    //   memberIds: conversation.memberIds ?? [],
    // );
    navigator.openMessagePage(friend);
  }

  void onPressSearch() {
    navigator.openSearchPage();
  }
}
