import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/models/enum/load_status.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  // loading status
  final LoadStatus loadDataStatus;
  final LoadStatus loadUpdateUserProfileStatus;

  final bool isSelectedAvatar;
  final String? selectedAvatar;
  final UserEntity? userInfo;

  const ProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.loadUpdateUserProfileStatus = LoadStatus.initial,
    this.selectedAvatar,
    this.userInfo,
    this.isSelectedAvatar = true,
  });

  // copy_with
  ProfileState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? loadUpdateUserProfileStatus,
    String? selectedAvatar,
    UserEntity? userInfo,
    bool? isSelectedAvatar,
  }) {
    return ProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      loadUpdateUserProfileStatus:
          loadUpdateUserProfileStatus ?? this.loadUpdateUserProfileStatus,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
      userInfo: userInfo ?? this.userInfo,
      isSelectedAvatar: isSelectedAvatar ?? this.isSelectedAvatar,
    );
  }

  @override
  List<Object?> get props => [
    loadDataStatus,
    loadUpdateUserProfileStatus,
    selectedAvatar,
    userInfo,
  ];
}
