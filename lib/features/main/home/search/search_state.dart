import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final List<UserEntity> listNonFriend;
  final List<UserEntity> listFriends;

  const SearchState({
    this.listNonFriend = const [],
    this.listFriends = const [],
  });

  // copy with
  SearchState copyWith({
    List<UserEntity>? listNonFriend,
    List<UserEntity>? listFriends,
  }) {
    return SearchState(
      listNonFriend: listNonFriend ?? this.listNonFriend,
      listFriends: listFriends ?? this.listFriends,
    );
  }

  @override
  List<Object?> get props => [listNonFriend, listFriends];
}
