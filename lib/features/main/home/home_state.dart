import 'package:chatbox/data/models/conversation/conversation_entity.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<UserEntity> onlineFriends;
  final List<ConversationEntity> chats;

  const HomeState({this.onlineFriends = const [], this.chats = const []});

  // copy with
  HomeState copyWith({
    List<UserEntity>? onlineFriends,
    List<ConversationEntity>? chats,
  }) {
    return HomeState(
      onlineFriends: onlineFriends ?? this.onlineFriends,
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [onlineFriends, chats];
}
