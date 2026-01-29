import 'package:chatbox/data/models/user_profile/user_entity.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final List<UserEntity> listNonFriend;
  final List<UserEntity> listFriends;


  const SearchState({this.listNonFriend = const [], this.listFriends = const []});

  // copy with
  SearchState copyWith({List<UserEntity>? listUsers}) {
    return SearchState(listNonFriend: listUsers ?? this.listNonFriend);
  }

  @override
  List<Object?> get props => [listNonFriend, listFriends];
}
