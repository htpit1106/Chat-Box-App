import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/models/enum/load_status.dart';
import 'package:equatable/equatable.dart';

class FriendProfileState extends Equatable {
  final LoadStatus loadData;
  final UserEntity? friendProfile;

  const FriendProfileState({
    this.loadData = LoadStatus.initial,
    this.friendProfile,
  });

  // copywith
  FriendProfileState copyWith({
    LoadStatus? loadData,
    UserEntity? friendProfile,
  }) {
    return FriendProfileState(
      loadData: loadData ?? this.loadData,
      friendProfile: friendProfile ?? this.friendProfile,
    );
  }

  @override
  List<Object?> get props => [loadData, friendProfile];
}
