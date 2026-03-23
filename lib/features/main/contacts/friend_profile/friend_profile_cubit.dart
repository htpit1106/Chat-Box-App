import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/features/main/contacts/friend_profile/friend_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendProfileCubit extends Cubit<FriendProfileState> {
  final UserEntity? friendProfile;

  FriendProfileCubit({this.friendProfile}) : super(FriendProfileState());

  void init() {
    emit(state.copyWith(friendProfile: friendProfile));
  }
}
